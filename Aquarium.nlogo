globals[Aquality caracolLevel1x caracolLevel2x caracolLevel1y caracolLevel2y HC HB VE VD UP DW header]

;Breeds

breed[fishA peixeA] ;breed de peixes A
breed[fishB peixeB] ;breed de peixes B
breed [sharks shark]
breed [food comida]
breed [caracois caracol]
breed [Salmonellas salmonella]


;OWNS
food-own [quantidade] ;agente de comida
patches-own[trash timecounter]
fishA-own [ageA ageA_counter count_eatenA doencaA doencacounterA]
fishB-own[ageB ageB_counter count_eatenB doencaB doencacounterB]
sharks-own[energy fishEaten]



;SETUP

to createfishs
  ;crio da breed A x Peixes
  create-fishA Pop_PeixeA
  [
    set shape "fish"
    set color violet
    setxy random-pxcor random-pycor
    set heading random 360
    set size 1
    set count_eatenA 0
    set doencaA 0
    set doencacounterA 0


    ; Idade de cada peixe
    set ageA 0
    set ageA_counter 0

  ]

  ;crio da breed B x Peixes
  create-fishB Pop_PeixeB
  [
    set shape "fish"
    set color red
    setxy random-pxcor random-pycor
    set heading random 360
    set size 1
    set count_eatenB 0
     set doencaB 0
    set doencacounterB 0

    ; Idade de cada peixe

   set ageB 0
   set ageB_counter 0

  ]
end

to setPatches
  ask patches
  [
    set pcolor 97
    set trash 0
    set timecounter 0
  ]
end

to setup
  clear-all  ;limpar a cena
  reset-ticks;resetar os ticks


  setPatches ;chamo a função para colocar os patches na forma base
  createfishs;chamo a função para criar os peixes das duas raças
  setupCleaning
end


;CONTROLADORES


to PEIXES_A_Controller
   ask fishA
 [


    set ageA_counter ageA_counter + 1 ;A cada Tick o contador de tempo é incrementado

    if ( ageA_counter >= 200) ; Se o contador chegar a 200
    [
      set ageA ageA + 1 ; Aumenta-se a idade do peixe em 1

      set ageA_counter 0 ; Contador de tempo volta a 0
    ]

    if(ageA >= Death_Age_FishA) ; se a idade do peixe for maior a idade controlada pela interface
    [
      die ;a turtle morre
    ]



   if(pycor = -16 )
    [
      right  90
      forward 1
    ]
    forward 1

     if(pycor = 16 )
    [
      right  90
      forward 1
    ]


    if(count fishA-on patch-here != 0) or (count fishA-on patch-here != 0)
    [
      set heading random 360
    ]
    forward 1




    if count_eatenA >= 3 ;se o peixe já comeu 3 comidas
    [
      (
        ifelse doencaA = 0
        [
          hatch 1 [setxy random-xcor random-ycor set ageA 0   set ageA_counter 0 set count_eatenA 0 set doencaA 0 set doencacounterA 0] ;nasce um peixe da sua breed
        ]

       doencaA = 1
        [
          hatch 1 [setxy random-xcor random-ycor set ageA 0   set ageA_counter 0 set count_eatenA 0 set doencaA 1 set doencacounterA 0] ;nasce um peixe da sua breed

        ]

      )
      set count_eatenA 0 ;reseto o contador da comida
    ]



     if count food-on patch-here != 0 ; se existe comida no patch onde o peixe se encontra
    [
    set count_eatenA count_eatenA + 1 ;aumenta-se o valor da comida
    ask food-on patch-here ;pergunta-se a comida
      [
      die ;comida morre
      ]
    ]

    if count Salmonellas-on patch-here != 0
    [
      set count_eatenA count_eatenA + 1 ;aumenta-se o valor da comida
      set doencaA 1

      ask Salmonellas-on patch-here ;pergunta-se a salmonella
      [
        die
      ]
    ]



    ; se tiver doente
    if (doencaA = 1 )
     [

        if ( doencacounterA > 25)
        [
          set color 57
        ]
         if ( doencacounterA > 50)
        [
          set color 55
        ]
         if ( doencacounterA > 75)
        [
          set color 53
        ]
        if ( doencacounterA >= 100)
        [
          die

        ]
        set doencacounterA doencacounterA + 1

    ]



   ]
end

to Peixes_B_Controller


 ask fishB
 [

    set ageB_counter ageB_counter + 1 ;A cada Tick o contador de tempo é incrementado
    if ( ageB_counter >= 200) ;se a idade chegar a 200 a sua idade aumenta
    [
      set ageB ageB + 1

      set ageB_counter 0 ;reseta o contador
    ]

    if(ageB >= Death_Age_FishB) ;para ver se morre
    [
      die
    ]

    if(pycor = -16 )
    [
      right  90
      forward 1
    ]
    forward 1

     if(pycor = 16 )
    [
      right  90
      forward 1
    ]


    if(count fishA-on patch-here != 0) or (count fishA-on patch-here != 0)
    [
      set heading random 360
    ]
    forward 1





   if count_eatenB >= 3 ;se o peixe já comeu 3 comidas
    [
      (
        ifelse doencaB = 0
        [
          hatch 1 [setxy random-xcor random-ycor set ageB 0   set ageB_counter 0 set count_eatenB 0 set doencaB 0 set doencacounterB 0] ;nasce um peixe da sua breed
        ]

       doencaB = 1
        [
          hatch 1 [setxy random-xcor random-ycor set ageB 0   set ageB_counter 0 set count_eatenB 0 set doencaB 1 set doencacounterB 0] ;nasce um peixe da sua breed

        ]

      )
      set count_eatenB 0 ;reseto o contador da comida
    ]



     if count food-on patch-here != 0 ; se existe comida no patch onde o peixe se encontra
    [
    set count_eatenB count_eatenB + 1 ;aumenta-se o valor da comida
    ask food-on patch-here ;pergunta-se a comida
      [
      die ;comida morre
      ]
    ]

    if count Salmonellas-on patch-here != 0
    [
      set count_eatenB count_eatenB + 1 ;aumenta-se o valor da comida
      set doencaB 1

      ask Salmonellas-on patch-here ;pergunta-se a salmonella
      [
        die
      ]
    ]
       ; se tiver doente
    if (doencaB = 1 )
     [

        if ( doencacounterB > 25)
        [
          set color 57
        ]
         if ( doencacounterB > 50)
        [
          set color 55
        ]
         if ( doencacounterB > 75)
        [
          set color 53
        ]
        if ( doencacounterB >= 100)
        [
          die

        ]
        set doencacounterB doencacounterB + 1

    ]

    ]
end

to Patches_Controller
;TIME COUNTERS
  ;a cada 500 ticks tornar a agua mais escura
 ask patches
 [
    if (timecounter >= 500)
    [
      if trash <= 5
      [
        set trash trash + 1
      ]

      set timecounter 0
    ]

  ]


;Verifica o nivel de lixo e o grau de sujidade e a partir dai muda a cor
  ask patches[
    set timecounter timecounter + 1
 (ifelse trash = 0
  [
    set pcolor 97 ; Apenas 5 niveis de sujidade
  ]
  trash = 1
  [
    set pcolor 96
  ]
   trash = 2
  [
    set pcolor 95
  ]
   trash = 3
  [
    set pcolor 94
  ]
   trash = 4
  [
    set pcolor 93
  ])

]

end

to Food_Controller

;Fazer com que a comida desca do aquario, sem limites ainda.
     ask food
  [
    forward 0.5

  ]

end

to Salmonellas_Controller

    ask Salmonellas
  [
    forward 0.5

  ]
end


;Funções

to go


  Peixes_A_Controller
  Peixes_B_Controller
  Patches_Controller
  Food_Controller
  Salmonellas_Controller
  getM

  tick

end


;Dar de Comer
to feed

   create-food Amount_Food
  [
    set shape "leaf"
    set color yellow
    setxy random-pxcor random 5 + 11
    set heading 180
    set size 0.8
  ]

  create-Salmonellas Amount_Poison_Food
  [
    set shape "turtle"
    set color 54
    set heading 180
    set size 0.8
    setxy random-pxcor random 5 + 11
  ]


end


;Media da Sujidade
to getM
ask patches
  [
    set Aquality Aquality + trash
  ]
  set Aquality Aquality / count patches

end


;Caracois
to setupCleaning


  (ifelse TypeOfCleaning = "Serpentine"
      [
        set header 0
        set caracolLevel1x 16
        set caracolLevel1y 16
        set caracolLevel2x -16
        set caracolLevel2y -15
        set HB 1
        set VE 0
        set HC 0
        set VD 0
      ]
      TypeOfCleaning = "Up&Down"
      [
        set header 270
        set UP 1
        set DW 0




      ]

    )
end

to clean ;CLEANING
  ask caracois[


    (ifelse TypeOfCleaning = "Random"
     [
        forward 1
        set heading random 360

        ask patch-here
        [
          set trash 0
        ]
    ]
      TypeOfCleaning = "Serpentine"
      [
        ask caracois
        [

          set trash 0
          fd 1
           if  [trash] of patch-here != 0
          [

            if pxcor = caracolLevel1x and HB = 1 and HC = 0 and VE = 0 and VD = 0
            [

              set trash  0
              set heading 0
              set caracolLevel1x caracolLevel1x - 1

              set HB 0
              set VD 1
              set VE 0
              set HC 0

              fd 1
            ]

            if pycor = caracolLevel1y and HB = 0 and HC = 0 and VE = 0 and VD = 1
            [
              set trash 0
              set heading 270
              set caracolLevel1y caracolLevel1y - 1

              set HB 0
              set VD 0
              set VE 0
              set HC 1

              fd 1
            ]
            if pxcor = caracolLevel2x and HB = 0 and HC = 1 and VE = 0 and VD = 0
            [
              set trash 0
              set heading 180
              set caracolLevel2x caracolLevel2x  + 1

              set HB 0
              set VD 0
              set VE 1
              set HC 0

              fd 1
            ]
            if pycor = caracolLevel2y and HB = 0 and HC = 0 and VE = 1 and VD = 0
            [
              set trash 0
              set heading 90
              set caracolLevel2y caracolLevel2y + 1

              set HB 1
              set VD 0
              set VE 0
              set HC 0
              set UP 1
              set DW 0

               fd 1
            ]

            if pycor = 0 and pxcor = 0
            [
              set trash 0
              setxy -16 -16
              setupCleaning
            ]
          ]


        ]
      ]
      TypeOfCleaning = "Up&Down"
      [
        set trash 0
        fd 1


        if UP = 1 and DW = 0 and pycor = 16
        [
          set trash 0
          rt 90
          fd 1
          set trash 0
          set heading 180
          set UP  0
          set DW  1
        ]
        if UP = 0 and DW = 1 and pycor = -16
        [
          set trash 0
          lt 90
          fd 1
          set trash 0
          set heading 0
          set UP  1
          set DW  0
        ]

      ]

    )



]
end

to createCaracol ;SPAWN CARACOL

  ;CREATE CARACOL
  create-caracois 1
  [
    setxy -16 -16
    set shape "car"

    set color blue
    set size 1.5

    (ifelse TypeOfCleaning = "Serpentine"
      [
        set heading 90
      ]
      TypeOfCleaning = "Up&Down"
      [
        set heading 0
      ]
    )

  ]
end


;SHARKS

to attack ;Shark ATTACK
  ask sharks [
    move
    eat-fish ; sharks eat a fish on their patch
    death ; sharks die if our of energy
    reproduce-sharks ; sharks reproduce at random rate governed by slider
  ]

end

to spawnSharks ;Sharks Spawn

   create-sharks 1
  [
    set shape "wolf"
    set color grey
    set size 2  ; easier to see
    setxy random-xcor random-ycor
    set energy 100
    set fishEaten 0
  ]

end

to move  ; turtle procedure
  rt random 50
  lt random 50
  fd 1
  set energy energy - 0.05
end

to eat-fish  ; shark prure
  let prey one-of fishA-here                    ; grab a random fish
  if prey != nobody  [                          ; did we get one?  if so,
    ask fishA-here
    [
      if doencaA = 1
      [
        ask sharks [ set energy 10 death]

      ]
    ]
    ask prey [ die ]                            ; kill it, and...
    set fishEaten fishEaten + 1     ; get energy from eating
  ]

  let prey2 one-of fishB-here                    ; grab a random fish
  if prey2 != nobody  [                          ; did we get one?  if so,
    ask fishB-here
    [
      if doencaB = 1
      [
        ask sharks [ set energy 10 death]

      ]
    ]
    ask prey2 [ die ]                            ; kill it, and...
    set fishEaten fishEaten + 1     ; get energy from eating
  ]
end

to death  ; turtle procedure (i.e. both shark nd fish procedure)
  ; when energy dips below fifteen, die
  if energy < Shark_Energy [ die ]
end

to reproduce-sharks  ; shark procedure
  if (fishEaten  > 3)[
    hatch 1 [ setxy random-xcor random-ycor set energy 100 set fishEaten 0 ]  ; hatch an offspring and move it forward 1 step
    set fishEaten 0
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
191
19
829
658
-1
-1
19.1
1
10
1
1
1
0
1
0
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
90
31
183
81
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
835
26
1007
59
Pop_PeixeA
Pop_PeixeA
0
100
0.0
1
1
NIL
HORIZONTAL

SLIDER
835
61
1007
94
Pop_PeixeB
Pop_PeixeB
0
100
0.0
1
1
NIL
HORIZONTAL

BUTTON
89
106
181
156
Go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
89
183
181
235
Feed
feed
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1008
369
1127
414
Numero de Comida
count food
17
1
11

INPUTBOX
836
96
1009
156
Death_Age_FishA
35.0
1
0
Number

INPUTBOX
836
161
1009
221
Death_Age_FishB
30.0
1
0
Number

MONITOR
1656
29
1739
70
PeixesA vivos
count fishA
17
1
10

MONITOR
1656
75
1742
116
PeixeB vivos
count fishB
17
1
10

CHOOSER
1073
493
1211
538
TypeOfCleaning
TypeOfCleaning
"Random" "Serpentine" "Up&Down"
1

BUTTON
833
485
944
545
Clean
clean
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
947
486
1068
545
NIL
createCaracol
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
832
419
944
478
Atacar
attack
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
946
419
1068
478
NIL
spawnSharks
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1656
119
1744
164
NIL
count sharks
17
1
11

PLOT
1013
28
1653
358
População
Ticks
População
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Peixes A" 1.0 0 -1184463 true "" "plot count fishA"
"Peixes B" 1.0 0 -2674135 true "" "plot count fishB"
"Tubarões" 1.0 0 -16448764 true "" "plot count sharks"

PLOT
1215
362
1554
541
Quantidade de Lixo na Agua
Ticks
Média
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Lixo" 1.0 0 -13345367 true "" "plot Aquality"

INPUTBOX
837
225
1010
285
Shark_Energy
15.0
1
0
Number

SLIDER
832
346
1004
379
Amount_Food
Amount_Food
0
15
12.0
1
1
NIL
HORIZONTAL

SLIDER
832
381
1004
414
Amount_Poison_Food
Amount_Poison_Food
0
8
3.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Circle -7500403 false true 45 75 150
Circle -7500403 false true 56 86 127
Circle -7500403 false true 66 96 108
Circle -7500403 false true 73 103 95
Circle -7500403 false true 86 116 67
Polygon -7500403 false true 120 225 91 219 71 206 60 196 7 225 4 241 34 241 195 240 226 182 251 189 265 169 258 138 244 126 214 132 190 176 170 206
Polygon -1184463 true false 118 225 121 227 96 221 79 212 62 196 9 226 6 243 197 240 225 182 256 189 267 170 252 188 268 169 259 138 247 126 214 131 182 191 171 206 146 219 125 226 123 227 119 227 120 225 120 225 120 225 120 225 120 225 124 226 121 227 107 224 125 228
Circle -6459832 true false 44 73 153
Circle -955883 true false 51 78 141
Circle -6459832 true false 66 91 114
Circle -955883 true false 72 100 96
Circle -16777216 true false 231 139 15
Polygon -1184463 true false 218 132 224 95 227 130 218 130 223 131
Polygon -1184463 true false 236 131 242 94 245 129 236 129 241 130
Circle -6459832 true false 217 90 12
Circle -6459832 true false 236 88 12

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Circle -7500403 true true 75 75 150

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 45 150 195 150 180 105 225 150 285 150 277 183 240 213 185 217 169 251 162 218 111 211 82 194 56 173 19 206 35 171 21 125 45 151 45 149 45 150 75 150 45 150
Circle -16777216 true false 255 165 0
Polygon -16777216 true false 264 156 256 167 268 174 274 164 266 157
Polygon -16777216 true false 254 202 214 193 275 184

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.3.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
