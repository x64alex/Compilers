import st
import re

def writePif(pif):
    pifFile = open("PIF.out", "w")
    for element in pif:
        pifFile.write(str(element)+"\n")

def writeST(identifiersST, integerST, stringST):
    stFile = open("ST.out", "w")

    stFile.write("Identifiers ST \n")
    stFile.write(str(identifiersST))

    stFile.write("\n\nInteger ST \n")
    stFile.write(str(integerST))

    stFile.write("\n\nString ST \n")
    stFile.write(str(stringST))


def writeFiles(pif, identifiersST, integerST, stringST):
    writePif(pif)
    writeST(identifiersST, integerST, stringST)

def scanner(programFile, tokenFile):
    delimiters = [",", ":", "(", ")", ">", "<","<=", ">=", "{", "}",  "&&", "||", "%", "==", "!=", "+", "-"]
    tokens = []
    pif = []
    identifiersST = st.HashTable(10)
    integerST = st.HashTable(10)
    stringST = st.HashTable(10)

    for token in tokenFile:
        if token[-1] == "\n":
            tokens.append(token[:-1])
        else:
            tokens.append(token)

    for index, line in enumerate(programFile):
        string = line
        for delimiter in delimiters:
            string = f" {delimiter} ".join(string.split(delimiter))

        for el in string.split():
            if el == "//":
                # if we have a comment ignore it
                break
            if el in tokens:
                # if el is reserved word, operator or separator
                pif.append((el, -1))
            elif el in "'":
                # change to contains "'"
                # identify constant string
                print(el)
            elif el.isnumeric():
                # identify constant integer
                position = integerST.insert(el)
                if position == -1:
                    position = integerST.lookup(el)
                pif.append(("integer", position))
            elif el.isalnum() and el[0].isalpha():
                # correct identifer
                position = identifiersST.insert(el)
                if position == -1:
                    position = identifiersST.lookup(el)
                pif.append(("id", position))
            else:
                writeFiles(pif, identifiersST, integerST, stringST)
                return f"lexical error at line {index+1} at identifier {el}"
    writeFiles(pif, identifiersST, integerST, stringST)
    return "lexically correct"



    


program1 = open("p1.cat")
program1er = open("p1err.cat")
program2 = open("p2.cat")
program3 = open("p3.cat")
program3string = open("p3string.cat")


tokens = open("token.in")

print(scanner(program2, tokens))
