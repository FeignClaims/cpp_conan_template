#!/usr/bin/env python3

import os
import sys


def match_file(file, target_name):
    '''
    Check if target can be matched by the file.
    By "match", we mean the corresponding file section is equal to the specified target section, or is wildcard '#'.
    -> -1 if not match
    -> equal_count if matches, standing for sections that equals
    '''
    equal_count = 0
    for file_section, target_section in zip(file.split('-'), target_name.split('-')):
        if file_section == "#":
            continue
        elif file_section == target_section:
            equal_count += 1
        else:
            return -1

    return equal_count


def find_most_matched_file(directory, target_name):
    '''
    Function to find the most matched file.
    - Among all matched files, the file has the maximum number of equal sections should be chosen;
    - if there're multiple files having maximum number of equal sections, the section-lexicographically less one should
      be chosen.
    '''
    most_matched = ""
    max_count = -1

    for file in os.listdir(directory):
        file_path = os.path.join(directory, file)
        if os.path.isfile(file_path) and os.path.splitext(file_path)[1] == '':
            count = match_file(file, target_name)
            if count == -1:
                continue
            elif count > max_count:
                most_matched = file
                max_count = count
            elif count == max_count:
                # If multiple files have the maximum count, choose the section-lexicographcially less one
                if file.split('-') < most_matched.split('-'):
                    most_matched = file

    return most_matched


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 match_conan_profile.py <conan_profile> (specified as <os>-<os_version>-<architecture>-<compiler>-<compiler_version>-<build_type>)")
        sys.exit(1)

    conan_profile = sys.argv[1]
    moset_matched_file = find_most_matched_file(
        os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "conan", "profiles"),
        conan_profile
    )
    print(f'{moset_matched_file}')
