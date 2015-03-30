def caesar(strin, offset):
    '''Strictly, a Caesar cipher is only an offset-3 cipher, but I like the name, so nyah. To decode, use a negative offset'''
    alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    outstr = ""
    strin = strin.lower()
    for letter in strin:
        if letter.isalpha():
            spot = alphabet.index(letter) + offset
            if spot>25 or spot<25:
                spot = spot % 26
            outstr += alphabet[spot]
        else:
            outstr = outstr + letter
    return outstr

def freqan(strin):
    ''' Basic frequency analysis for a given string '''
    alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    strin = strin.lower()
    for letter in alphabet:
        print letter+': ',strin.count(letter)

#print "pbeguuymiqicuufguuyiqguuyqcuivfiqguuyqcuqbemevp"
#freqan("pbeguuymiqicuufguuyiqguuyqcuivfiqguuyqcuqbemevp")

#print "jrgdgidxgqanngzgtgttsitgjranmnoeddiomnwjrajvksexjmdxkmnwjrgmttgdtgognjajmzgovgkinlaqgtjamnxmsmjjrgkojtgnwjrgnjrgvattmgtawamnojjrgwizgtnsgnjibabgu"
#freqan("jrgdgidxgqanngzgtgttsitgjranmnoeddiomnwjrajvksexjmdxkmnwjrgmttgdtgognjajmzgovgkinlaqgtjamnxmsmjjrgkojtgnwjrgnjrgvattmgtawamnojjrgwizgtnsgnjibabgu")

