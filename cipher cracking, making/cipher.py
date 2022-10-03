import binascii
import csv
import random
from base64 import b64encode

'''
Name:Kokil Dhakal
Source:
    https://inventwithpython.com/cracking/chapter5.html
    https://stackoverflow.com/questions/613183/how-do-i-sort-a-dictionary-by-value
Extension: No
Collaborator:None


'''


def binary_to_string(n):
    # Helper function that will return ascii from binary
    # Use this to get the original message from a binary number
    return n.to_bytes((n.bit_length() + 7) // 8, 'big').decode()


def string_to_binary(string):
    # Helper function that will return binary from string
    # Use this to get a number from the message
    return int.from_bytes(string.encode(), 'big')


def binary_to_binary_string(binary):
    # Helper function that will return binary as a bit string from binary
    # Use this to convert the binary number into a string of 0s and 1s.
    # This is needed to generate the appropriate random key
    return bin(binary)[2:]


def binary_string_to_binary(bin_string):
    # Helper function that will return binary from a bit string
    # Use this to convert the random key into a number for calculations
    return int(bin_string, 2)


def get_random_bit():
    # Helper function that will randomly return either 1 or 0 as a string
    # Use this to help generate the random key for the OTP
    return str(random.randint(0, 1))


def read_message():
    # Helper function that will read and process message.txt which will provide a good testing message
    message = ''
    f = open('message.txt', 'r')
    for line in f:
        message += line.replace('\n', ' ').lower()
    return message


class Cipher:

    def __init__(self):
        # Initialize the suite
        # In part 1 create letter_dict and inverse_dict
        # In part 3 create letter_heuristics and call self.read_csv()
        self.letter_dict = {'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7,
                            'i': 8, 'j': 9, 'k': 10, 'l': 11, 'm': 12, 'n': 13, 'o': 14,
                            'p': 15, 'q': 16, 'r': 17, 's': 18, 't': 19, 'u': 20,
                            'v': 21, 'w': 22, 'x': 23, 'y': 24, 'z': 25, ' ': 26}

        self.inverse_dict = {v: k for k, v in self.letter_dict.items()}

        self.letter_heuristics = {'A': 0, 'B': 0, 'C': 0, 'D': 0, 'E': 0, 'F': 0,
                                  'G': 0, 'H': 0, 'I': 0, 'J': 0, 'K': 0, 'L': 0, 'M': 0, 'N': 0,
                                  'O': 0, 'P': 0, 'Q': 0, 'R': 0, 'S': 0, 'T': 0, 'U': 0, 'V': 0,
                                  'W': 0, 'X': 0, 'Y': 0, 'Z': 0}
        # self.wordlist = []
        # self.read_csv('letter_frequencies.csv')



    def rotate_letter(self, letter, n):
        if n > 27:
            n = n % 27
        self.letter = letter
        # Rotate a letter by n and return the new letter
        if letter not in self.letter_dict.keys():
            return letter

        initial_position = self.letter_dict[letter]
        final_position = initial_position + n
        if final_position > 26:
            final_position = final_position - 27
            letter_after_rotation = self.inverse_dict[final_position]

        else:
            letter_after_rotation = self.inverse_dict[final_position]

        return letter_after_rotation

    def encode_caesar(self, message, n):
        # Encode message using rotate_letter on every letter and return the cipher text
        cipher_text = ""
        for letter in message.lower():
            if letter in self.letter_dict.keys():
                cipher_text += self.rotate_letter(letter, n)
            else:
                cipher_text += letter
        return cipher_text

    def decode_caesar(self, cipher_text, n):
        # Decode a cipher text by using rotate_letter the opposite direction and return the original message
        if n > 27:
            n = n % 27
        decode = ""
        for char in cipher_text.lower():  # converts all letter to lowercase
            if char not in self.letter_dict.keys():  # handles char other than alphabet
                decode += char
                continue
            initial_position = self.letter_dict[char]
            final_position = initial_position - n
            if final_position < 0:
                final_position = 27 + final_position
                letter_after_rotation = self.inverse_dict[final_position]
                decode += letter_after_rotation
                continue

            letter_after_rotation = self.inverse_dict[final_position]

            decode += letter_after_rotation

        return decode

    def read_csv(self):
        # Read the letter frequency csv and create a heuristic save in a class variable
        # dict_from_csv = {}
        with open('letter_frequencies.csv', mode='r') as file:
            reader = csv.reader(file)
            dict_from_csv = {rows[0]: rows[1] for rows in reader}
            dict_from_csv.pop('Letter')

        return dict_from_csv
        # file = 'letter_frequencies.csv'

    def for_brute_force(self, cipher_text):
        all_translate = []
        for key in range(27):
            translated = ''
            for symbol in cipher_text:
                if symbol in self.letter_dict.keys():  # handles char other than letter
                    num = self.letter_dict[symbol]
                    num = num - key
                    if num < 0:
                        num = num + 27
                        translated = translated + self.inverse_dict[num]

                    else:
                        translated = translated + self.inverse_dict[num]
                else:
                    translated = translated + symbol

            all_translate.append(translated)

        return all_translate

    def score_string(self):
        string = self.for_brute_force(cipher_text)
        total_score = []
        for lines in string:
            score = 0
            for char in lines:
                if char == "e":
                    score += 1
                elif char == "t":
                    score += 0.74
                elif char == "a":
                    score += 0.64
                elif char == "i":
                    score += 0.61
                elif char == "o":
                    score += 0.61
                elif char == "n":
                    score += 0.58
                elif char == 's':
                    score += 0.52
                elif char == 'r':
                    score += 0.5
                elif char == 'h':
                    score += 0.4
                elif char == 'l':
                    score += 0.33
                elif char == 'd':
                    score += 0.31
                elif char == 'c':
                    score += 0.27
                elif char == 'u':
                    score += 0.22
                elif char == 'm':
                    score += 0.2
                elif char == 'f':
                    score += 0.19
                elif char == 'p':
                    score += 0.17
                elif char == 'g':
                    score += 0.15
                elif char == 'w':
                    score += 0.13
                elif char == 'y':
                    score += 0.13
                elif char == 'b':
                    score += 0.12
                elif char == 'v':
                    score += 0.08
                elif char == 'k':
                    score += 0.04
                elif char == 'x':
                    score += 0.02
                elif char == 'j':
                    score += 0.01
                elif char == 'q':
                    score += 0.01
                elif char == 'z':
                    score += 0.01
                elif char == ' ':
                    score += 1.01

            total_score.append(score)

        return total_score

    def crack_caesar(self, cipher_text):
        list_of_score = self.score_string()
        # finding max score among list of scores
        high_score = 0
        for score in list_of_score:
            if score > high_score:
                high_score = score

        cipher_key = list_of_score.index(high_score)  # index of max score is key we are looking for
        decode = ""
        for char in cipher_text.lower():  # converts all letter to lowercase
            if char not in self.letter_dict.keys():  # handles char other than alphabet
                decode += char
                continue
            initial_position = self.letter_dict[char]
            final_position = initial_position - cipher_key
            if final_position < 0:
                final_position = 27 + final_position
                letter_after_rotation = self.inverse_dict[final_position]
                decode += letter_after_rotation
                continue

            letter_after_rotation = self.inverse_dict[final_position]

            decode += letter_after_rotation

        return decode

    def encode_vigenere(self, message, key):
        # Encode message using rotation by key string characters
        encoded_message = ""
        key = key.lower()  # handling uppercase letter in key
        keyIndex = 0
        for char in message.lower():  # handling uppercase letter in message
            if char in self.letter_dict.keys():  # handling char other than letter
                char_position = self.letter_dict[char]
                # char position rotate by value of the key's char
                char_position += self.letter_dict[key[keyIndex]]
                keyIndex += 1
                # Handling any wraparound
                if char_position > 26:
                    char_position = char_position - 27
                    final_position = self.inverse_dict[char_position]

                else:
                    final_position = self.inverse_dict[char_position]

                encoded_message += final_position
            else:
                encoded_message += char
            # moving to next index of key
            # rotating use of key
            if keyIndex == len(key):
                keyIndex = 0

        return encoded_message

    def decode_vigenere(self, cipher_text, key):
        # Decode ciphertext using rotation by key string characters
        decoded_message = ""
        key = key.lower()
        keyIndex = 0
        # looping over cipher_text finding position adding repective key postion and again coverting to letter
        for char in cipher_text.lower():
            if char in self.letter_dict.keys():  # handling if there is any char other than letter
                char_position = self.letter_dict[char]

                char_position -= self.letter_dict[key[keyIndex]]
                keyIndex += 1
                # Handling any wraparound
                if char_position < 0:
                    char_position = char_position + 27
                    final_position = self.inverse_dict[char_position]

                else:
                    final_position = self.inverse_dict[char_position]
                # handling any wraparound

                decoded_message += final_position
            else:
                decoded_message += char
            # moving to next index of key
            # rotating use of key
            if keyIndex == len(key):
                keyIndex = 0

        return decoded_message

    def encode_otp(self, message):
        # Similar to a vernan cipher, but we will generate a random key string and return it
        messageToBinary = string_to_binary(message)  # changing message to binary numbers
        # changing binary number to binary strings to find out length  so that same length of key can be produced
        messageToBinaryString = binary_to_binary_string(messageToBinary)
        key = ""
        for i in range(len(messageToBinaryString)):
            digit = get_random_bit()
            key += digit

        key = binary_string_to_binary(key)
        cipher_text = messageToBinary ^ key  # XOR bitwise operation to get new cipher_text
        return cipher_text, key

    def decode_otp(self, cipher_text, key):
        # XOR cipher text and key. Convert result to string
        decoded_number = cipher_text ^ key  # xor bitwise operation between cipher_text and key number to get original
        #  message
        decoded_message = binary_to_string(decoded_number)
        return decoded_message

    def read_wordlist(self):
        # Extra Credit: Read all words in wordlist and store in list. Remember to strip the endline characters
        wordlist = []
        with open("wordlist.txt") as file:
            for word in file:
                wordlist.append(word.rsplit())

        return wordlist


def crack_vigenere(self, cipher_text):
    # Extra Credit: Break a vigenere cipher by trying common words as passwords
    # Return both the original message and the password used
    self.read_wordlist()
    return None, None


if __name__ == '__main__':
    print("---------------------TEST CASES---------------------------")
    cipher_suite = Cipher()
    print("---------------------PART 1: CAESAR-----------------------")

    message = read_message()
    cipher_text = cipher_suite.encode_caesar(message, 5)
    # print(cipher_suite.for_brute_force(cipher_text))
    print('Encrypted Cipher Text:', cipher_text)
    decoded_message = cipher_suite.decode_caesar(cipher_text, 5)
    print('Decoded Message:', decoded_message)
    print("------------------PART 2: BREAKING CAESAR------------------")
    cracked = cipher_suite.crack_caesar(cipher_text)
    print('Cracked Code:', cracked)
    print("---------------------PART 3: Vignere----------------------")
    password = 'dog'
    print('Encryption key: ', password)
    cipher_text = cipher_suite.encode_vigenere(message, password)
    print('Encoded:', cipher_text)
    decoded_message = cipher_suite.decode_vigenere(cipher_text, password)
    print('Decoded:',  decoded_message)

    print("-----------------------PART 4: OTP------------------------")

    cipher_suite.encode_otp(message)
    cipher_text, key = cipher_suite.encode_otp(message)

    decoded_message = cipher_suite.decode_otp(cipher_text, key)
    print('Cipher Text:', cipher_text)
    print('Generated Key:', key)
    print('Decoded:', decoded_message)

# print('---------PART 5: Breaking Vignere (Extra Credit)----------')
# cipher_text = cipher_suite.encode_vigenere(message, password)
# cracked, pwrd = cipher_suite.crack_vigenere(cipher_text)
# print('Cracked Code:', cracked)
# print('Password:', pwrd)
