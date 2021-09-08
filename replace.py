# replace.py
# USAGE: python replace.py bad-word good-word target-file.txt
# Source: https://superuser.com/questions/422459/substitution-in-text-file-without-regular-expressions

import sys

search_term = sys.argv[1]
replace_term = sys.argv[2]
target_file = sys.argv[3]

with open(target_file, 'r') as file:
        content = file.read()

content = content.replace(sys.argv[1], sys.argv[2])

with open(target_file, 'w') as file:
        file.write(content)
