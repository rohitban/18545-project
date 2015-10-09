radix = """MEMORY_INITIALIZATION_RADIX=16;\nMEMORY_INITIALIZATION_VECTOR="""

sliceIndex = 2
readCount = 5


#program to read rom files and generate a
#byte addressable .coe file
def main():

	coe_string = radix
	folder = "text_roms/"
	files = ["code_rom1.txt","code_rom2.txt","code_rom3.txt","code_rom4.txt"]
	
	try:
		for fileName in files:
			path = folder+fileName
			for line in open(path):
				for word in line.split(" "):
					firstByte = word[:sliceIndex]
					assert(len(firstByte)==2)
					coe_string += "\n" + firstByte + ','
					secondByte = word[sliceIndex:readCount-1]
					coe_string += "\n" + secondByte + ','
					
	except:
		print("File open failure")

	coe_string = coe_string[:len(coe_string)-1] + ";"
	print(coe_string)

	

if __name__ == "__main__":
	main()
    