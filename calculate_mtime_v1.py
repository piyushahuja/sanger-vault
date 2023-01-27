import base64
import csv
import time

input_file = "20210817_114.dat"
base_dir = b"/lustre/scratch114/teams/hgi/user"
encoded_base_dir = base64.b64encode(base_dir).decode('utf-8')
check_base_dir = "/lustre/scratch114/teams/hgi/users/"

max_mtime = 0
min_mtime = int(time.time())

with open(input_file, 'r') as mpi_data:
    reader = csv.reader(mpi_data, delimiter='\t')
    i = 0
    for row in reader:
        if str(row[7]) == "f":
            mtime = int(row[5])
            filepath = row[0]
            if filepath.startswith(encoded_base_dir):
                decoded_path = base64.b64decode(filepath).decode()
                if decoded_path.startswith(check_base_dir):
                    min_mtime = min(mtime, min_mtime)
                    if min_mtime == mtime:
                        print(f"File with new minimum: {decoded_path} mtime: {mtime}")
                    max_mtime = max(mtime, max_mtime)
                    if max_mtime == mtime:
                        print(f"File with new maximum: {decoded_path} mtime: {mtime}")
                else: 
                    print(f"Skipped file: {decoded_path}")
        
    
print(f"Maximum mtime: {max_mtime} Minimum mtime: {min_mtime}")