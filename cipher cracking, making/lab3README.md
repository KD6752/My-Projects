Name:Kokil Dhakal
Collaborator:None
Extension:None
Source: https://inventwithpython.com/cracking/chapter5.html
  https://stackoverflow.com/questions/613183/how-do-i-sort-a-dictionary-by-value
  
**Estra credit work at the last of this file......**

lab 3 working process:
I will be explaining by method used in this process.

Design:
1.Caesar Cipher:
Caesar cipher encrypting decrypting process is easier one. As encryption take place by replacing each letter of the message with another letter with a fixed key number. So we will be provided message to be encrypted and key with wich each letter of that message will be encrypted. For this  we need a dictionary key as letter and number as value upto 26. now we go throuh each letter of the message and caculate its position in letter dictionary. then add postion value by key number and find out the final postion number in leter dictionary. and finally find the letter representing that final postion number. and this letter represent encrypted letter. similarly, we go over each letter of the message and convert to encrypted message. 
for decoding cipher, we do same process but in reverse direction i.e. we substract key value instead addition.
Finally, we also have to handle wrap around. 

2. breaking Caesar Cipher:
for this we use Brute Force technique and frequecy analysis of the letters from cipher text. we have provied the frequcy occurence of letter in english language. based on  that we will will find key to decrypt the cipther text.  first we make a dictionary in wich couter for each letter is 0. we well go ove each letter of the cipher text and add number of occurence  of each letter and finaly sorted descending order.we will check higher number of occurece of letter and mapped with higher number with higher number of occurecne letter in english which is e followed by t etc. so combition of brute force wich gives 26 posibilities and frequecy analysis we can crack caesar cipher.

3. Vegenere cipher: this is simiar to ecrypting and decrypting caesar cipher except the key. instead of using single letter or a number this process uses a group of letters as key that will be repeated ove. on this we have to handle two wrap around one on message and another on key. number of words in key will be repeated over untill all letters in message is encrypted. decrypting vegenere cipher is similar to encrypting but in reverse direction.

4.OTP:
for this we approach differently instead of using dictionary we use binary number.each letter in message  are  converted to binary numeric and we will randomly produce the keys same lenth of that message binary number. after that we use bitwise XOR operation between binary key and binary message numeric.product from this operation will be encrypted cipher text. similary, we will decrypt the cipher text numeric by doing xor with same key  and then convert to message string.

Extra Credit:
2.one time pad is a way to make vigenere cipher unbreakable. it ueses one time randomly generated key which length is as same as the length of message. these three criteria makes OTP imposible to hack.number of possible keys will be 26 raised power of the total number of letters in the message which is a very big number. Also, there is possibility of same ciphertext from multiple message. so it is hard for cryptanalyst to figure out which is original message even if he/she able to crack key by using powerfull computers.(reference from https://inventwithpython.com/cracking/chapter21.html)

3.In vigenere cipher we use same keys multiple times over the lenth of a message.resuing same key over a message is same as reusing key multiple times in vigenere cipher,which is hackable.that is why reusing same key in OTP is vulnerable to be hacked.


