# Compile and execute any assembly file
```nasm -f elf64 filename.asm && ld -o filename filename.o && ./filename```

# Compile and execute fibonacci
```nasm -f elf64 fibonacci.asm```
```nasm -f elf64 print_unsigned_int.asm```
```ld print_unsigned_int.o fibonacci.o -o fibonacci```
```./fibonacci```
