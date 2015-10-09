import sys

radix = """MEMORY_INITIALIZATION_RADIX=16;\nMEMORY_INITIALIZATION_VECTOR="""

readCount = 5


#program to read rom files and generate a
#byte addressable .coe file
def main():

	cmd_args = sys.argv
	total_args = len(cmd_args)

	if(total_args < 1):
		print("Pass a valid filename as an arg!!")
		return

	coe_string = radix
	filename = cmd_args[1]
    
    readType = cmd_args[2]
	
	try:
		for line in open(filename):
			for word in line.split(" "):
                
				word = word[:readCount-1]
				coe_string += "\n" + word + ','
	except:
		print("File open failure")

	coe_string = coe_string[:len(coe_string)-1] + ";"
	print(coe_string)

	

if __name__ == "__main__":
	main()
    
