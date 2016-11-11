#Samuel Lamb
#Miniproject 1
#2/9/2015
#Python 2.7.5

def vigenere(text, key):
    alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    text = text.lower()
    text = text.replace(' ','')
    key = key.lower()
    key = key.replace(' ','')
    outtext = ""
    for i,letter in enumerate(text):
        outtext += alphabet[(alphabet.index(letter) + alphabet.index(key[(i % len(key))])) % 26]
    return outtext

def devigenere(text, key):
    alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    text = text.lower()
    text = text.replace(' ','')
    key = key.lower()
    key = key.replace(' ','')
    outtext = ""
    for i,letter in enumerate(text):
        outtext += alphabet[(alphabet.index(letter) - alphabet.index(key[(i % len(key))])) % 26]
    return outtext

#print vigenere("to be or not to be that is the question", "relations")
#print devigenere(vigenere("To be or Not to Be That is the Question", "relations"), 'relations')
