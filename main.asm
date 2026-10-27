section .text
    global _start


_not_enough_money:
    ;Ecrir "Vous n'avez pas asser d'argent il vous reste x €"
    mov edx, len_not_enough_money
    mov ecx, not_enough_money
    mov ebx, 1
    mov eax, 4
    int 0x80

    call _print_numbers

    mov edx, len_euros
    mov ecx, euros
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _start

_print_water:
    ;Afficher "Eau"
    mov edx, len_water
    mov ecx, water
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _start

_print_soda:
    ;Afficher "Soda"
    mov edx, len_soda
    mov ecx, soda
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _start

_print_sandwitch:
    ;Afficher "Sandwitch"
    mov edx, len_sandwitch
    mov ecx, sandwitch
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _start

_buy_successful:
    ;Afficher le message "Vous avez bien acheter"
    mov edx, len_buy_successful
    mov ecx, buy_successful
    mov ebx, 1
    mov eax, 4
    int 0x80

    cmp dword [what_buy], 1
    je _print_water 
    cmp dword [what_buy], 2
    je _print_soda
    cmp dword [what_buy], 3
    je _print_sandwitch

    jmp _start

_buy_water:
    mov eax, [argent]
    
    ;Verifier si l'utilisateur a asser d'argent 
    cmp eax, 2
    jl _not_enough_money

    ;Si il a asser lui enlever l'argent 
    sub dword [argent], 2

    ;Afficher le message d'achat réusit
    mov dword [what_buy], 1
    jmp _buy_successful

_buy_soda:
    mov eax, [argent]

    ;Verifier si l'utilisateur a asser d'argent 
    cmp eax, 3
    jl _not_enough_money

    ;Si il a asser lui enlever l'argent
    sub dword [argent], 3

    ;Afficher le message d'achat réusit
    mov dword [what_buy], 2
    jmp _buy_successful

_buy_sandwitch:
    mov eax, [argent]

    ;Verifier si l'utilisateur a asser d'argent 
    cmp eax, 5
    jl _not_enough_money

    ;Si il a asser lui enlever l'argent
    sub dword [argent], 5

    ;Afficher le message d'achat réusit
    mov dword [what_buy], 3
    jmp _buy_successful

_print_numbers:
    ;Fonction pour afficher des nombre
    mov eax, [argent]
    xor edx, edx
    mov ebx, 10
    div ebx

    ;Convertir en ASCII
    add eax, '0'
    add edx, '0'

    ;Mettre les chiffre dans des variables et les afficher
    mov [buffer], al
    mov [buffer + 1], dl

    ;Afficher les chifre
    mov edx, 2
    mov ecx, buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ret

_print_sold:
    ;Affiche le sold 
    ;Vous avez 
    mov edx, len_sold
    mov ecx, sold
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher 20
    call _print_numbers

    ;Afficher "Euros"
    mov edx, len_euros
    mov ecx, euros
    mov ebx, 1
    mov eax, 4
    int 0x80

_start:
    ;Afficher le menu 
    mov edx, len_menu
    mov ecx, menu
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Connaitre le choix de l'utilisateur
    mov edx, 2
    mov ecx, choix
    mov ebx, 0
    mov eax, 3
    int 0x80

    cmp byte [choix], '1'
    je _buy_water
    cmp byte [choix], '2'
    je _buy_soda
    cmp byte [choix], '3'
    je _buy_sandwitch
    cmp byte [choix], '4'
    je _print_sold

    jmp _end

_end:
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .bss
    choix resb 2
    buffer resb 2

section .data
    argent dd 20
    what_buy dd 0

    water db "Eau", 0xa
    len_water equ $ - water

    soda db "Soda", 0xa
    len_soda equ $ - soda

    sandwitch db "Sandwitch", 0xa
    len_sandwitch equ $ - sandwitch

    menu db 0xa, "1. Eau 2€", 0xa
         db "2. Soda 3€", 0xa
         db "3. Sandwitch 5€", 0xa
         db "4. Voir mon sold", 0xa
         db "5. Quitter", 0xa
    len_menu equ $ - menu

    not_enough_money db "Vous n'avez pas asser d'argent. Il vous reste :"
    len_not_enough_money equ $ - not_enough_money
    
    sold db "Vous avez "
    len_sold equ $ - sold

    euros db " €", 0xa
    len_euros equ $ - euros

    buy_successful db "Vous avez bien acheter "
    len_buy_successful equ $ - buy_successful