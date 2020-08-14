## MacOS / Unix 

## 1. Check header of any file 

    nm your_file 
    
## 2. Find a file 


    find tmp/dynamo_home -iname "Foundation.h"
    
    
## 3. Create a text file and send content to it 

    touch content.txt
    echo "something" >> content.txt
    
## 4. Fetch content 


    cat file.txt | grep "keyword"
