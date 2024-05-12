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


def replace_in_directory(directory_path, search_pattern, replace_text, patterns):
    for root, _, files in os.walk(directory_path):
        for file in files:
            if any(fnmatch.fnmatch(file, pattern) for pattern in patterns):
                file_path = os.path.join(root, file)

                # Replace in file contents
                replace_file_content(file_path, search_pattern, replace_text)

                # Replace in file name
                os.rename(file_path, os.path.join(root, file.replace(search_pattern, replace_text)))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 rename_project.py <new_project_name>")
        sys.exit(1)

    replace_in_directory(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                         "replace_this",
                         sys.argv[1],
                         ["CMakeLists.txt", "README*", "*.cmake", "*.cpp", "*.hpp"])
    replace_in_directory(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                         "REPLACE_THIS",
                         sys.argv[1].upper(),
                         ["CMakeLists.txt", "README*", "*.cmake", "*.cpp", "*.hpp"])
