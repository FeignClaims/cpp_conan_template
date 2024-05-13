#!/usr/bin/env python3
import os
import fnmatch
import sys


def replace_file_content(file_path, search_text, replace_text):
    with open(file_path, 'r') as file:
        content = file.read()

    new_content = content.replace(search_text, replace_text)

    with open(file_path, 'w') as file:
        file.write(new_content)


def replace_file_name(file_path, search_text, replace_text):
    os.rename(
        file_path, os.path.join(
            os.path.dirname(file_path),
            os.path.basename(file_path).replace(search_text, replace_text)))


def replace_directories(directory_path, search_text, replace_text):
    for root, dirs, _ in os.walk(directory_path, topdown=False):
        for dir in dirs:
            replace_file_name(os.path.join(root, dir), search_text, replace_text)


def replace_files(directory_path, search_text, replace_text, file_patterns):
    for root, _, files in os.walk(directory_path):
        for file in files:
            if any(fnmatch.fnmatch(file, pattern) for pattern in file_patterns):
                file_path = os.path.join(root, file)
                replace_file_content(file_path, search_text, replace_text)
                replace_file_name(file_path, search_text, replace_text)


def replace(directory_path, search_text, replace_text, file_patterns):
    replace_directories(directory_path, search_text, replace_text)
    replace_files(directory_path, search_text, replace_text, file_patterns)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 rename.py <old_name> <new_name>")
        sys.exit(1)

    old_name = sys.argv[1]
    new_name = sys.argv[2]

    replace(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
            sys.argv[1],
            sys.argv[2],
            ["CMakeLists.txt", "README*", "*.cmake", "*.cpp", "*.hpp", "conanfile.*"])
    replace(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
            sys.argv[1].upper(),
            sys.argv[2].upper(),
            ["CMakeLists.txt", "README*", "*.cmake", "*.cpp", "*.hpp", "conanfile.*"])
