#!/usr/bin/env python3
"""
Cross-language equivalence test: Generate golden reference from OOGGA Python primitives.

Extracts OOGGA's collision-checking primitives (__find_identities, __overlap_pass)
and runs them on a battery of test cases. Outputs JSON for R-side verification.

Source: OOGGA.py (Mukundan & Madhusudhan 2025), lines 182-200.
Repo: github.com/bigbigdumdum/OOGGA

Usage:
    python3 scripts/oogga_golden_reference.py > tests/testthat/fixtures/oogga_golden_reference.json
"""

import json


# === OOGGA primitives (extracted verbatim from OOGGA.py) ===


def get_rc(DNA):
    """Reverse complement. From OOGGA.py lines 383-388."""
    DNA_complements = {
        "A": "T",
        "T": "A",
        "G": "C",
        "C": "G",
        "W": "W",
        "S": "S",
        "M": "K",
        "K": "M",
        "R": "Y",
        "Y": "R",
        "B": "V",
        "D": "H",
        "H": "D",
        "V": "B",
        "N": "N",
    }
    return "".join([DNA_complements[x] for x in DNA[::-1]])


def find_identities(overhangs, current_overhang):
    """Count positional identity for each overhang vs candidate.
    From OOGGA.py lines 196-200."""
    ns = []
    for ovrhg in overhangs:
        ns.append(
            sum(
                [
                    1 if current_overhang[x] == ovrhg[x] else 0
                    for x in range(len(current_overhang))
                ]
            )
        )
    return ns


def overlap_pass(candidate, prior_ohs, alien_ohs, max_identity=2):
    """
    Simulate OOGGA's __overlap_pass() collision check.

    From OOGGA.py lines 182-194:
        overhangs = [self.seq[x:x+4] for x in js] + [self.seq[-4:]] + self.alien_overhangs
        identities = self.__find_identities(
            overhangs + [self.get_rc(x) for x in overhangs + [current_overhang]],
            current_overhang
        )

    In the full OOGGA, `overhangs` = trace-back OHs + last_seq_oh + aliens.
    For primitive testing, we combine prior_ohs and alien_ohs into one list
    (the distinction is architectural, not algorithmic).

    The check list passed to find_identities is:
        overhangs + RC(overhangs) + RC(candidate)
    i.e., candidate is checked against each overhang directly AND its RC,
    plus candidate's own RC (self-palindrome check).
    """
    overhangs = list(prior_ohs) + list(alien_ohs)
    # Build the full check list (exactly as OOGGA does it)
    check_list = overhangs + [get_rc(x) for x in overhangs + [candidate]]
    identities = find_identities(check_list, candidate)
    for x in identities:
        if x > max_identity:
            return False
    return True


# === Test case generation ===


def generate_test_cases():
    """Generate test cases covering all aspects of OOGGA's collision logic."""
    results = {
        "metadata": {
            "source": "OOGGA.py (Mukundan & Madhusudhan 2025)",
            "repo": "github.com/bigbigdumdum/OOGGA",
            "description": "Golden reference for cross-language equivalence testing",
            "max_identity_default": 2,
        },
        "tests": {},
    }

    # --- 1. Positional identity counts ---
    identity_tests = []
    pairs = [
        ("AATC", "AATG"),  # 3 matches (A,A,T match; C vs G no)
        ("AATC", "CATT"),  # 0 matches
        ("AATT", "AATT"),  # 4 matches (identical)
        ("ACGT", "ACGT"),  # 4 matches (true palindrome)
        ("ACGC", "GCGT"),  # 0 matches
        ("AAAA", "AAAA"),  # 4 matches (homopolymer)
        ("ACGT", "TGCA"),  # 0 matches (RC of ACGT = ACGT, but TGCA is different)
        ("GATC", "GATC"),  # 4 matches (palindrome: RC(GATC) = GATC)
        ("CGTC", "AGTC"),  # 3 matches (positions 2,3,4 match)
        ("TTTT", "AAAA"),  # 0 matches
        ("ACAC", "ACAC"),  # 4 matches
        ("GTGT", "ACAC"),  # 0 matches
    ]
    for a, b in pairs:
        ids = find_identities([b], a)
        identity_tests.append({"oh_a": a, "oh_b": b, "identity": ids[0]})
    results["tests"]["positional_identity"] = identity_tests

    # --- 2. Self-palindrome checks ---
    # OOGGA checks identity(candidate, RC(candidate)) > max_identity
    self_palindrome_tests = []
    candidates = [
        "AATT",  # RC = AATT, identity = 4 -> REJECT at mi=2
        "ACGT",  # RC = ACGT, identity = 4 -> REJECT (true palindrome)
        "GATC",  # RC = GATC, identity = 4 -> REJECT (true palindrome)
        "ACGC",  # RC = GCGT, identity = 0 -> PASS
        "AATC",  # RC = GATT, identity = 1 (only T at pos 3) -> PASS
        "TGCA",  # RC = TGCA, identity = 4 -> REJECT (true palindrome)
        "CATG",  # RC = CATG, identity = 4 -> REJECT (true palindrome)
        "TTAA",  # RC = TTAA, identity = 4 -> REJECT (true palindrome)
        "AAAC",  # RC = GTTT, identity = 0 -> PASS
        "AACG",  # RC = CGTT, identity = 0 -> PASS
        "CCAG",  # RC = CTGG, identity = 1 -> PASS
        "ATCG",  # RC = CGAT, identity = 0 -> PASS
        "ATAT",  # RC = ATAT, identity = 4 -> REJECT (palindrome)
    ]
    for cand in candidates:
        rc_cand = get_rc(cand)
        identity_with_rc = find_identities([rc_cand], cand)[0]
        # overlap_pass with no prior/alien tests only the self-palindrome
        passes = overlap_pass(cand, [], [], max_identity=2)
        self_palindrome_tests.append(
            {
                "candidate": cand,
                "rc_candidate": rc_cand,
                "identity_with_rc": identity_with_rc,
                "passes_mi2": passes,
                "passes_mi3": overlap_pass(cand, [], [], max_identity=3),
            }
        )
    results["tests"]["self_palindrome"] = self_palindrome_tests

    # --- 3. Pairwise compatibility (2-condition check) ---
    # OOGGA checks candidate against each "other" OH:
    #   - identity(candidate, other) <= max_identity
    #   - identity(candidate, RC(other)) <= max_identity
    compat_tests = []
    pairs_to_test = [
        # (candidate, other, description)
        ("AATC", "AATG", "3 direct matches"),
        ("AATC", "CCAG", "low direct identity"),
        ("ACCA", "TGGT", "RC match: RC(TGGT)=ACCA, id=4"),
        ("GCAC", "GTGC", "RC match: RC(GTGC)=GCAC, id=4"),
        ("TGAA", "GGAA", "3 direct matches (pos 2,3,4)"),
        ("CCTC", "GAGG", "RC match: RC(GAGG)=CCTC, id=4"),
        ("ACAA", "TAGA", "low identity both ways"),
        ("CGGA", "CATA", "2 direct matches, low RC"),
        ("AACG", "AAGT", "2 direct matches (A,A), check RC"),
    ]
    for cand, other, desc in pairs_to_test:
        id_direct = find_identities([other], cand)[0]
        rc_other = get_rc(other)
        id_rc = find_identities([rc_other], cand)[0]
        # Check if candidate passes overlap_pass against this single other
        # (assumes candidate itself is not a self-palindrome)
        passes_mi2 = overlap_pass(cand, [other], [], max_identity=2)
        passes_mi3 = overlap_pass(cand, [other], [], max_identity=3)
        compat_tests.append(
            {
                "candidate": cand,
                "other": other,
                "description": desc,
                "identity_direct": id_direct,
                "rc_other": rc_other,
                "identity_with_rc": id_rc,
                "passes_mi2": passes_mi2,
                "passes_mi3": passes_mi3,
            }
        )
    results["tests"]["pairwise_compatibility"] = compat_tests

    # --- 4. Full overlap_pass with prior + alien overhangs ---
    # Simulates actual OOGGA DP scenarios
    full_tests = []

    # Scenario A: candidate ACCA with 2 priors and 1 alien
    scenario_a = {
        "name": "typical_3_existing_ohs",
        "candidate": "ACCA",
        "prior_ohs": ["CCTC", "TGAA"],
        "alien_ohs": ["GCAC"],
        "max_identity": 2,
    }
    scenario_a["result"] = overlap_pass(
        scenario_a["candidate"],
        scenario_a["prior_ohs"],
        scenario_a["alien_ohs"],
        scenario_a["max_identity"],
    )
    # Also compute detailed breakdown
    all_ohs = scenario_a["prior_ohs"] + scenario_a["alien_ohs"]
    check_list = all_ohs + [get_rc(x) for x in all_ohs + [scenario_a["candidate"]]]
    scenario_a["check_list"] = check_list
    scenario_a["identities"] = find_identities(check_list, scenario_a["candidate"])
    full_tests.append(scenario_a)

    # Scenario B: candidate that collides with a prior OH
    scenario_b = {
        "name": "collision_with_prior",
        "candidate": "AATG",
        "prior_ohs": ["AATC"],
        "alien_ohs": [],
        "max_identity": 2,
    }
    scenario_b["result"] = overlap_pass(
        scenario_b["candidate"],
        scenario_b["prior_ohs"],
        scenario_b["alien_ohs"],
        scenario_b["max_identity"],
    )
    all_ohs_b = scenario_b["prior_ohs"] + scenario_b["alien_ohs"]
    check_list_b = all_ohs_b + [
        get_rc(x) for x in all_ohs_b + [scenario_b["candidate"]]
    ]
    scenario_b["check_list"] = check_list_b
    scenario_b["identities"] = find_identities(check_list_b, scenario_b["candidate"])
    full_tests.append(scenario_b)

    # Scenario C: candidate that collides via RC of alien
    scenario_c = {
        "name": "collision_via_rc_alien",
        "candidate": "ACCA",
        "prior_ohs": [],
        "alien_ohs": ["TGGT"],  # RC(TGGT) = ACCA, identity = 4
        "max_identity": 2,
    }
    scenario_c["result"] = overlap_pass(
        scenario_c["candidate"],
        scenario_c["prior_ohs"],
        scenario_c["alien_ohs"],
        scenario_c["max_identity"],
    )
    all_ohs_c = scenario_c["prior_ohs"] + scenario_c["alien_ohs"]
    check_list_c = all_ohs_c + [
        get_rc(x) for x in all_ohs_c + [scenario_c["candidate"]]
    ]
    scenario_c["check_list"] = check_list_c
    scenario_c["identities"] = find_identities(check_list_c, scenario_c["candidate"])
    full_tests.append(scenario_c)

    # Scenario D: self-palindrome rejection (candidate is its own RC)
    scenario_d = {
        "name": "self_palindrome_rejection",
        "candidate": "AATT",
        "prior_ohs": [],
        "alien_ohs": [],
        "max_identity": 2,
    }
    scenario_d["result"] = overlap_pass(
        scenario_d["candidate"],
        scenario_d["prior_ohs"],
        scenario_d["alien_ohs"],
        scenario_d["max_identity"],
    )
    check_list_d = [get_rc(scenario_d["candidate"])]
    scenario_d["check_list"] = check_list_d
    scenario_d["identities"] = find_identities(check_list_d, scenario_d["candidate"])
    full_tests.append(scenario_d)

    # Scenario E: candidate passes at mi=3 but not mi=2
    scenario_e = {
        "name": "passes_mi3_fails_mi2",
        "candidate": "AATG",
        "prior_ohs": ["AATC"],
        "alien_ohs": [],
        "max_identity_values": [2, 3],
    }
    scenario_e["result_mi2"] = overlap_pass(
        scenario_e["candidate"],
        scenario_e["prior_ohs"],
        scenario_e["alien_ohs"],
        max_identity=2,
    )
    scenario_e["result_mi3"] = overlap_pass(
        scenario_e["candidate"],
        scenario_e["prior_ohs"],
        scenario_e["alien_ohs"],
        max_identity=3,
    )
    full_tests.append(scenario_e)

    # Scenario F: large set of priors (simulates deep DP path)
    scenario_f = {
        "name": "many_priors_deep_path",
        "candidate": "CTAA",
        "prior_ohs": ["CCTC", "GACA", "GCAC", "AATC", "GTAA", "TGAA"],
        "alien_ohs": ["ATTA", "CCAG"],
        "max_identity": 2,
    }
    scenario_f["result"] = overlap_pass(
        scenario_f["candidate"],
        scenario_f["prior_ohs"],
        scenario_f["alien_ohs"],
        scenario_f["max_identity"],
    )
    all_ohs_f = scenario_f["prior_ohs"] + scenario_f["alien_ohs"]
    check_list_f = all_ohs_f + [
        get_rc(x) for x in all_ohs_f + [scenario_f["candidate"]]
    ]
    scenario_f["check_list"] = check_list_f
    scenario_f["identities"] = find_identities(check_list_f, scenario_f["candidate"])
    full_tests.append(scenario_f)

    # Scenario G: Potapov Set 3 overhangs — check all pairwise
    potapov_set3 = [
        "CCTC",
        "CTAA",
        "GACA",
        "GCAC",
        "AATC",
        "GTAA",
        "TGAA",
        "ATTA",
        "CCAG",
        "AGGA",
        "ACAA",
        "TAGA",
        "CGGA",
        "CATA",
        "CAGC",
        "AACG",
        "AAGT",
        "CTCC",
        "AGAT",
        "ACCA",
        "AGTG",
        "GGTA",
        "GCGA",
        "AAAA",
        "ATGA",
    ]
    # Check each Potapov OH against all others at mi=2
    potapov_compat = {}
    for i, oh in enumerate(potapov_set3):
        others = potapov_set3[:i] + potapov_set3[i + 1 :]
        passes = overlap_pass(oh, others, [], max_identity=2)
        potapov_compat[oh] = passes
    scenario_g = {
        "name": "potapov_set3_mutual_compat",
        "potapov_set3": potapov_set3,
        "all_pass_mi2": potapov_compat,
        "n_passing": sum(1 for v in potapov_compat.values() if v),
        "n_failing": sum(1 for v in potapov_compat.values() if not v),
    }
    full_tests.append(scenario_g)

    results["tests"]["full_overlap_pass"] = full_tests

    # --- 5. Reverse complement verification ---
    rc_tests = []
    seqs = ["ACGT", "AATT", "GATC", "TGCA", "AAAA", "CCCC", "ACGC", "TGAA"]
    for seq in seqs:
        rc_tests.append({"input": seq, "rc": get_rc(seq)})
    results["tests"]["reverse_complement"] = rc_tests

    return results


if __name__ == "__main__":
    results = generate_test_cases()
    print(json.dumps(results, indent=2))
