import st
import re


def scanner(programFile, tokenFile):
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
        for el in line.split():
            if el == "//":
                # if we have a comment ignore it
                break
            if el in tokens:
                # if el is reserved word, operator or separator
                pif.append((el, 0))
            elif el == "'":
                # identify constant string
                print(el)
            elif isinstance(el, int):
                # identify constant integer
                position = integerST.insert(el)
                pif.append(("integer", position))
            elif el.isalnum() and el[0].isalpha():
                # correct identifer
                position = identifiersST.insert(el)
                pif.append(("id", position))
            else:
                return f"lexical error at line {index} at identifier {el}"
    print(identifiersST)

    return "lexically correct"



    


program1 = open("p1.cat")
program1er = open("p1err.cat")
program2 = open("p2.cat")
program3 = open("p3.cat")

tokens = open("token.in")

print(scanner(program1, tokens))