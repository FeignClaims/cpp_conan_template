import subprocess
import os
import sys


def replace_in_files_and_filenames(directory, search_text, replace_text):
    git_files = subprocess.check_output(['git', 'ls-files'], cwd=directory, text=True).splitlines()

    for item_path in git_files:
        # Replace in file names
        new_item_path = item_path.replace(search_text, replace_text)
        if item_path != new_item_path:
            os.rename(os.path.join(directory, item_path), os.path.join(directory, new_item_path))

        # Replace in file contents
        with open(os.path.join(directory, new_item_path), 'r') as file:
            file_content = file.read()
        new_content = file_content.replace(search_text, replace_text)
        with open(os.path.join(directory, new_item_path), 'w') as file:
            file.write(new_content)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 rename_project.py <project_root_path> <new_project_name>")
        sys.exit(1)

    directory = sys.argv[1]
    search_text = "replace_this"
    replace_text = sys.argv[2]

    replace_in_files_and_filenames(directory, search_text, replace_text)
