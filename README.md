### **[Design C :](https://github.com/Abdelrahman-Adel610/Full_AES-Verilog/tree/master/Full_AES%20design%20C)**
### Brief :
This desgin is a sequential design for AES128/AES192/AES256 that is depending on a contoller to switch between the 3 systems by settign nr (number of rounds per operation for the system) .
The main module is runnig the whole operation in (2*nr+1) round and (2*nr) clk .
In the round (nr+1)  we get our cipher ,in the round (2*nr+1) we decipher it and get out original input .
At the final round if the input is as same as the output of the decryption operation the flag turns on ==> the input is successfully encrypted and decrypted  :white_check_mark::white_check_mark:.  
### Functionality :
1. The main module is (AES) ,this module takes two parameters nr-->number of rounds , nk-->number of bytes.
2. It generates the full_key depending on the the parameters,
3. Each clock the input state for the encryption or decryption (depending on the counter) is been changed depending on the AES logic.
4. By any change on the counter the Display reg is been updated according [the AES logic](https://github.com/Abdelrahman-Adel610/Full_AES-Verilog/blob/master/NIST.FIPS.197.pdf). (Display reg is resposible for storing the least eight significant bits of each state at the begining of the round )

_To switch between the the AES systems you have to reset then switch (no parallel output)_
**for parallel output ,kindly go to design A or B :relaxed::relaxed:**
