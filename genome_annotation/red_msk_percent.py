import sys

def string_test(filename):
    with open(filename, 'r') as file:
        content = file.readlines()

    d = {"UPPER_CASE": 0, "LOWER_CASE": 0}
    for line in content:
        if line.startswith(">"):
            continue  # Skip lines starting with ">"
        
        for c in line:
            if c.isupper():
                d["UPPER_CASE"] += 1
            elif c.islower():
                d["LOWER_CASE"] += 1
            else:
                pass

    print("No. of Upper case characters: ", d["UPPER_CASE"])
    print("No. of Lower case Characters: ", d["LOWER_CASE"])
    total_characters = d["LOWER_CASE"] + d["UPPER_CASE"]
    if total_characters > 0:
        lower_case_percentage = (d["LOWER_CASE"] / total_characters) * 100
        print("Percent of Lower case Characters: ", lower_case_percentage)
    else:
        print("No characters found in the file.")

if __name__ == '__main__':
    if len(sys.argv) > 1:
        string_test(sys.argv[1])
    else:
        print("Please provide a filename as a command-line argument.")