### Vad är det här?
Jämför 4x4 matris multiplikationer i Zig. <br/>
Gör 10.000.000 multiplikationer för en SIMD och vanlig variant. <br/>

### Resultat:
Tydligen är Zig kompilatorn smart nog att optimera den vanliga array varianten till SIMD. <br/>
Resultat variabeln är markerad med `doNotOptimizeAway()` i båda varianter, så att multiplikationen blir tvingad att utföras. <br/>
Jag testade på en Intel Core i7-8700 CPU 3.20GHz och kompilerade med `-Doptimize=ReleaseFast`. <br/>
Tydligen var array varianten snabbare. `objdump` visar att båda funktionerna blir till SIMD instruktioner. <br/>
|Variant:                     |Tid i millisekunder (snitt):|
|:----------------------------|---------------------------:|
|10.000.000 mat4 x mat4       |360.386 ms                  |
|10.000.000 mat4 x mat4 (SIMD)|467.597 ms                  |