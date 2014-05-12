Version 1/140509 of Spanish Language by Sebastian Arg begins here.

"To make Spanish the language of play."

"basada en InformATE! de Zak"

Volume 1 - Settings

[A language extension is required to set the following variable correctly:]

The language of play is the Spanish language.

[The following only needs to be done for inflected languages which distinguish
the genders -- which is why English doesn't do it.]

An object has a grammatical gender.

[Inform initialises this property sensibly. We can easily check the results:

	When play begins:
		repeat with T running through things:
			say "[T] has [grammatical gender of T]."

By default, if Inform can't see any reason to choose a particular gender,
it will use neuter. We want to change that for French, since French doesn't
have neuter nouns:]

The grammatical gender of an object is usually masculine gender.
The grammatical gender of a woman is usually feminine gender.

Volume 2 - Language

Part 2.1 - Determiners

Chapter 2.1.1 - Articles

To say el (O - object):
	say "[the O]".

To say un (O - object):
	say "[a O]".

To say El (O - object):
	say "[The O]".

To say Un (O - object):
	say "[A O]".

Include (-
language Spanish
[ver 9/pro.5 p94]

<indefinite-article> ::=
	/b/ un    |			[singular, masculine]
	/c/ una   |			[singular, feminine]
	/e/ unos  |     [plural, masculine (by default)]
	/f/ unas        [plural, feminine]

<definite-article> ::=
	/b/ el  |				[singular, masculine]
	/c/ la  |				[singular, feminine]
	/e/ los |		  	[plural, masculine (by default)]
	/f/ las					[plural, femenine]

[6/noun.15 p29]
<np-relative-phrase-implicit> ::=
	/a/ vestido por |     [replacing "worn" in English]
	/b/ llevado por |     ["carried"]
	/c/ llevado inicialmente por | ["initial carried"]
	/d/ aquí              ["here"]

[19/play.10 p148]
<implicit-player-relationship> ::=
	/a/ vestido |
	/b/ llevado |
	/c/ llevado inicialmente por ["initial carried" deprecated for the future]

[19/play.4] [todo: lo siguiente parece no funcionar]
<notable-player-variables>  ::=
  /a/ jugador |       [player]
  /b/ puntuación |    [score]
  /c/ hora            [time of day]

-) in the Preform grammar.

Include (-
language Spanish

[todo : lo siguiente no anda]
<heading> ::=
    /a/ volumen ... |						
		/b/ libro ... |							
		/c/ parte ... |							
		/d/ capítulo/capitulo ... |						
		/e/ sección/seccion ...							

-) in the Preform grammar.

Include (-
Constant LanguageAnimateGender   = male;
Constant LanguageInanimateGender = male;

Constant LanguageContractionForms = 1;     ! Para el español
! No se produce contracción del artículo. Sólo de las preposiciones
! como en "del" y "al", pero eso no está contemplado por el manual
! del traductor, por lo que es necesario otro tipo de truco

[ LanguageContraction ;
    return 0;
];

Array LanguageArticles -->
    ! Forma de contracción 0:
    ! Cdef   Def  Indef  
    "El " "el " "un "    
    "La " "la " "una "   
    "Los " "los " "unos "  
    "Las " "las " "unas ";

                   !             a           i
                   !             s     p     s     p
                   !             m f n m f n m f n m f n                 
Array LanguageGNAsToArticles --> 0 1 0 2 3 2 0 1 0 2 3 2;
-) instead of "Articles" in "Language.i6t".


Chapter 2.1.2 - Numbers

Include (-
language Spanish

<cardinal-number-in-words> ::=
	cero |
	uno/una |
	dos |
	tres |
	cuatro |
	cinco |
	seis |
	siete |
	ocho |
	nueve |
	diez |
	once |
	doce

<ordinal-number-in-words> ::=
	cero |			[¿Existe esta palabra en español?]
	primero |
	segundo |
	tercero |
	cuarto |
	quinto |
	sexto |
	séptimo |
	octavo |
	noveno |
	décimo |
	undécimo |
	duodécimo

-) in the Preform grammar.

Include (-
Array LanguageNumbers table
    'un' 1 'uno' 1 'una' 1 'dos' 2 'tres' 3 'cuatro' 4 'cinco' 5
    'seis' 6 'siete' 7 'ocho' 8 'nueve' 9 'diez' 10
    'once' 11 'doce' 12 'trece' 13 'catorce' 14 'quince' 15
    'dieciséis' 16 'diecisiete' 17 'dieciocho' 18 'diecinueve' 19
    'veinte' 20;

[ LanguageNumber n venti m f;
    if (n==0) { print "cero"; rfalse; }
    if (n<0) { print "menos "; n=-n; }
#Iftrue (WORDSIZE == 4);
    if (n >= 1000000000) {
        !if (f == 1) print ", ";
    	!print (LanguageNumber) n/1000000000, " billón"; n = n%1000000000; f = 1;
		if (n<2000000000) print "mil";
        else { LanguageNumber(n/1000000000,1); print " mil";} 
        n=n%1000000000; f = 1;
        if (n~=0) print " ";
    }
    if (n >= 1000000) {
    	print (LanguageNumber) n/1000000;
		if ((n<2000000) && (f==0)) print " millón";
        else { print " millones";} 
        n = n%1000000;
        if (n~=0) print " ";
    }
#Endif;
    if (n>=1000) { 
		if (n<2000) print "mil";
        else { LanguageNumber(n/1000,1); print " mil";} 
        n=n%1000; 
        if (n~=0) print " ";
    }
    if (n>=100)  { 
		CientosEspanol(n/100); 
        if (n%100~=0) print " ";
		n=n%100; 
    }
    if (n==0) rfalse;

    if (n<10) {
		DigitoEspanol(n); rfalse;
    }
    if (n>=20)
	{	m=n/10;
        if (n%10~=0) {
				if (m==2) print "veinti";
            } else {
				if (m==2) print "veinte";
            }
            if (m==3) print "treinta";
			if (m==4) print "cuarenta";
            if (m==5) print "cincuenta";
            if (m==6) print "sesenta";
            if (m==7) print "setenta";
            if (m==8) print "ochenta";
            if (m==9) print "noventa";
            if (n%10==0) rfalse;
            if (m>2) print " y "; 
            DigitoEspanol(n%10, (m==2)&&(venti==0)); rfalse;
        }
    if (n==10) { print "diez"; rfalse; }
    if (n==11) { print "once"; rfalse; }
    if (n==12) { print "doce"; rfalse; }
    if (n==13) { print "trece"; rfalse; }
    if (n==14) { print "catorce"; rfalse; }
    if (n==15) { print "quince"; rfalse; }
    if (n==16) { print "dieciséis"; rfalse; }
    if (n==17) { print "diecisiete"; rfalse; }
    if (n==18) { print "dieciocho"; rfalse; }
    print "diecinueve";
];

[ DigitoEspanol n venti;
    if (n==1) { print "un"; rfalse; }
    if (n==2) { 
         if (venti) {print "dós";} else {print "dos"; };
         rfalse; }
    if (n==3) { 
         if (venti) {print "trés";} else {print "tres"; };
         rfalse; }
    if (n==4) { print "cuatro"; rfalse; }
    if (n==5) { print "cinco"; rfalse; }
    if (n==6) { 
         if (venti) {print "séis";} else {print "seis"; };
         rfalse; }
    if (n==7) { print "siete"; rfalse; }
    if (n==8) { print "ocho"; rfalse; }
    if (n==9) { print "nueve"; rfalse; }
];

[ CientosEspanol n;
	if (n==1) { print "ciento"; rfalse; }
	if (n==2) { print "dos";}
	if (n==3) { print "tres";}
	if (n==4) { print "cuatro";}
	if (n==5) { print "quinientos"; rfalse;}
	if (n==6) { print "seis";}
	if (n==7) { print "sete";}
	if (n==8) { print "ocho";}
	if (n==9) { print "nove";}
	print "cientos"; rfalse;
];
-) instead of "Numbers" in "Language.i6t".


Part 2.2 - Nouns

Chapter 2.2.2 - Pronouns and possessives for the player 

[The adaptive text viewpoint is the viewpoint of the player when we are
writing response texts which need to work in any tense, person or number.
For example, English uses first person plural, so we write "[We] [look] up."
as a message which could come out as "I look up", "you look up", "he looks up",
and so on. It's "[We]" not "[You]" because the adaptive text viewpoint is
first person plural, not second person singular.

The reason for choosing this in English was that all the pronouns and
possessive adjectives we needed happened to be different for first person
plural: we, us, ours, ourselves, our. We also need these pronouns to be
other than third-person, so that we can define [they], [them] and so on
to refer to objects and not the player. So in practice there are only four
possible choices a language extension can make:

	first person singular (in English: I, me, mine, myself, my)
	second person plural (in English: you, you, yours, yourself, your)
	first person singular (in English: we, us, ours, ourselves, our)
	second person plural (in English: you, you, yours, yourself, your)

What shall we choose for French? We may as well use second person singular,
giving us tu, te, le tien/la tienne, te, ton. There are two complications.
Firstly we need indirect objects as well as direct objects, and although these
are the same in second person (te and te), they're different in third person
(le and lui). We'll call this "[te-lui]" for the same of this demonstration,
which is a bit awkward, but it'll do. Secondly, the reflexive pronoun is also
te, so we'll write that one "[te-se]".
Spanish: We use 2PS.
]

The adaptive text viewpoint of the Spanish language is second person singular.

[So now we define the following text substitutions:

French:[tu], [te], [te-lui], [te-se], [le tien], [ton]

Spanish: [tu], [ti], [tuyo], [le tien], [ton]

and their capitalised forms, which start with "T" not "t".]

[en general Poca gente menciona los sujetos explícitamente en segunda persona.Al-K]

Include Text Capture by Eric Eve.

to say plm:[primera letra en mayúscula]
	stop capturing text;
	say "[captured text]" in sentence case.

To say tu:
	now the prior named object is the player;[ object's identity is a value stored in "prior named object"]
	if the story viewpoint is third person singular:
		if the player is male:
			say " él";
		otherwise:
			say " ella";
	if the story viewpoint is third person plural:
		if the player is male:
			say " ellos";
		otherwise:
			say " ellas".
			

To say Tu:
	now the prior named object is the player;[ object's identity is a value stored in "prior named object"]
	if the story viewpoint is first person singular:
		start capturing text;
	if the story viewpoint is second person singular:
		start capturing text;
	if the story viewpoint is third person singular:
		if the player is male:
			say "Él";
		otherwise:
			say "Ella";
	if the story viewpoint is first person plural:
		start capturing text;
	if the story viewpoint is second person plural:
		start capturing text;	
	if the story viewpoint is third person plural:
		if the player is male:
			say "Ellos";
		otherwise:
			say "Ellas".



To say él:
	now the prior named object is the player;[ object's identity is a value stored in "prior named object"]
	if the story viewpoint is third person singular:
		if the player is male:
			say " él";
		otherwise:
			say " ella";
	if the story viewpoint is third person plural:
		if the player is male:
			say " ellos";
		otherwise:
			say " ellas".
			

To say Él:
	now the prior named object is the player;[ object's identity is a value stored in "prior named object"]
	if the story viewpoint is first person singular:
		start capturing text;
	if the story viewpoint is second person singular:
		start capturing text;
	if the story viewpoint is third person singular:
		if the player is male:
			say "Él";
		otherwise:
			say "Ella";
	if the story viewpoint is first person plural:
		start capturing text;
	if the story viewpoint is second person plural:
		start capturing text;	
	if the story viewpoint is third person plural:
		if the player is male:
			say "Ellos";
		otherwise:
			say "Ellas".

Chapter 2.2.3 - Pronouns and possessives for other objects

[These are similar, but easier. They are named from the third-person viewpoint
with the same number as the adaptive text viewpoint; so in the case of French,
we'll go with third person singular. We define:

	[celui] = that
	[il] = it as subject
	[le] = it as object
	[lui] = it as indirect object
	[son] = its as adjective, e.g., "its temperature"
	[le sien] = its as possessive pronoun, e.g., "that label is its"

Spanish: 3PS
	[eso] = that
	[il] = it as subject
	[le] = it as object
	[lui] = it as indirect object
	[son] = its as adjective, e.g., "its temperature"
	[le sien] = its as possessive pronoun, e.g., "that label is its"

and similarly for its capitalised forms.]

To say eso:
	let the item be the prior named object;
	if the item is the player:
		say "[tu]";
	otherwise:
		if the item is plural-named:
			if the item is male:
				say "esos";
			otherwise:
				say "esas";
		otherwise:
			if the item is male:
				say "eso";
			otherwise:
				say "esa".

To say Eso:
	let the item be the prior named object;
	if the item is the player:
		say "[Tu]";
	otherwise:
		if the item is plural-named:
			if the item is male:
				say "Esos";
			otherwise:
				say "Esas";
		otherwise:
			if the item is male:
				say "Eso";
			otherwise:
				say "Esa".

Chapter 2.2.4 - Directions

North translates into Spanish as el norte.
South translates into Spanish as el sur.
East translates into Spanish as el este.
West translates into Spanish as el oeste.
Northeast translates into Spanish as el noreste.
Southwest translates into Spanish as el suroeste.
Southeast translates into Spanish as el sureste.
Northwest translates into Spanish as el noroeste.
Inside translates into Spanish as dentro.
Outside translates into Spanish as fuera.
Up translates into Spanish as arriba.
Down translates into Spanish as abajo.


Understand "o" as west.
Understand "no" as northwest.
Understand "so" as southwest.
Understand "sube/techo/lado/cielo" as up.
Understand "b/baja/suelo" as down.
Understand "adentro" as inside. ['entra' no funciona aqui pues se superpone con verbo 'entra..']
Understand "afuera" as outside.

Up is proper-named.
Down is proper-named.
Inside is proper-named.
Outside is proper-named.


Chapter 2.2.5 - Kinds

Section 2.2.5.1 - In the Standard Rules

[One day we will also want to translate the names of more abstract kinds, but
for now, we'll just translate kinds of objects. This ensures that if we write:

	Quatre hommes sont dans la Théâtre.

then (a) Inform will recognise these as instances of the kind "man", and (b)
it will give them each the printed name "homme" (not "man").

I'm not sure I've chosen the best equivalents here. Should a room be "chamber",
or "pièce"?]

A room translates into Spanish as una habitación.
A thing translates into Spanish as un objeto.
A door translates into Spanish as una puerta.
A container translates into Spanish as un contenedor.
A vehicle translates into Spanish as un vehículo.
A player's holdall translates into Spanish as un bolsa.
A supporter translates into Spanish as un soporte.
A backdrop translates into Spanish as un decorado.
A person translates into Spanish as una persona.
A man translates into Spanish as un hombre.
A woman translates into Spanish as una mujer.
A animal translates into Spanish as un animal.
A device translates into Spanish as un dispositivo.
A direction translates into Spanish as una dirección.
A region translates into Spanish as una región.

Chapter 2.2.6 - Plurals

Include (-
language Spanish

[We define a trie to construct the plural of a French noun. This is fairly
regular in French:]

<singular-noun-to-its-plural> ::=
	<es-plural-exceptions> |
	...	<es-plural-by-ending> |
	... <es-plural-default>

<es-plural-exceptions> ::=
	pies			pies |
	monsieur		messieurs

<es-plural-by-ending> ::=
	*s			0 |	[tas -> tas]
	*ón     2ones |		[camión->camiones]
	*or     0es |		[contenedor->contenedores]
  *<aeiou>y 0es		[ley -> leyes]
  
<es-plural-default> ::=
	*		0s

-) in the Preform grammar.



Chapter 2.2.7 - Cases

[This will be significant for languages like German, but for French there's
nothing to do.]

Chapter 2.2.8 - Times of day

Include (-
! Spanish Version of the saying 'time of day in words'
![ PrintTimeOfDaySpanish t h m dir aop say_minutes quad;
[ PrintTimeOfDayEnglish t h m dir aop say_minutes quad;

!   t store the minutes from 0am until now
!  se tiene en cuenta: 8:40 nueve menos veinte
!                               8:15 ocho y cuarto
!                               8:53 7 minutos para las nueve
!	                    8:14 ocho horas y catorce minutos
!           		        1:20 una y veinte (y todas las variantes con 'una')

    quad = 1; ! =1 es la primera media hora, =2 es la segunda
    h = (t/60) % 12; m = t%60; if (h==0) h=12;
	if (m==0) { if(h==1) print "una"; else print (number) h;print " en punto"; return; } !infsp hack
	dir = "y";! infsp hack
	if (m > 30) { m = 60-m; h = (h+1)%12; if (h==0) h=12; dir = "menos"; quad=2;} !infsp hack
	switch(m) {
        5: say_minutes = "cinco";
        10:say_minutes = "diez";
		15: say_minutes = "cuarto";
        20: say_minutes = "veinte";
        25: say_minutes = "veinticinco";
        30: say_minutes = "media";
		default: 
            if (quad == 2){
              print (number) m;
		      if (m%5 ~= 0) {
					if (m == 1) print " minuto"; else print " minutos"; ! infsp hack
		      }
              if(h==1) print " para la una"; else print " ", "para las ", (number) h;!infsp hack

            }
            if (quad == 1){
              if(h==1) print "una y "; else print (number) h," horas "; print (number) m;
		      if (m%5 ~= 0) {
					if (m == 1) print " minuto"; else print " minutos"; ! infsp hack
		      }
            }
        	return;
	}
	if(h==1) print "una"; else print (number) h; print " ",(string) dir, " ",(string) say_minutes;!infsp hack
]; 
-) instead of "Analogue Printing" in  "Time.i6t".

[spanish version: minuto, hora, de, etc]
Include (-
[ RELATIVE_TIME_TOKEN first_word second_word offhour mult mn original_wn;
	original_wn = wn;
	wn = original_wn;
	
	first_word = NextWordStopped(); wn--;
!	if (first_word == 'an' or 'a//') mn=1; else mn=TryNumber(wn);
	if (first_word == 'una' or 'un') mn=1; else mn=TryNumber(wn);
	
    if (mn == -1000) {
		first_word = NextWordStopped();
		if (first_word == 'media') offhour = HALF_HOUR;
		if (first_word == 'cuarto') offhour = QUARTER_HOUR;
		if (offhour > 0) {
			second_word = NextWordStopped();
			if (second_word == 'de') second_word = NextWordStopped();
!			if (second_word == 'an') second_word = NextWordStopped();
			if (second_word == 'hora') {
				parsed_number = offhour;
				return GPR_NUMBER;
			}
		}
		return GPR_FAIL;
    }
	wn++;
	
	first_word = NextWordStopped();
	switch (first_word) {
		'minutos', 'minuto': mult = 1;
		'hora', 'horas': mult = 60;
		default: return GPR_FAIL;
	}
	parsed_number = mn*mult;
	if (mult == 60) {
		mn=TryNumber(wn);
		if (mn ~= -1000) {
			wn++;
			first_word = NextWordStopped();
			if (first_word == 'minutos' or 'minuto')
				parsed_number = parsed_number + mn;
			else wn = wn - 2;
		}
	}
	return GPR_NUMBER;
];
-) instead of "Relative Time Token" in  "Time.i6t".


Part 2.3 - Adjectives

[Adjectives have six forms: neuter singular, neuter plural, masculine singular,
masculine plural, feminine singular, feminine plural. They're constructed
using tries:

	n.s.		(base text unchanged)
	n.p.		base modified by <adjective-to-plural>
	m.s.		base modified by <adjective-to-masculine-singular>
	m.p.		base modified by <adjective-to-masculine-singular>
				then further by <adjective-to-masculine-plural>
	f.s.		base modified by <adjective-to-feminine-singular>
	f.p.		base modified by <adjective-to-feminine-singular>
				then further by <adjective-to-feminine-plural>

For French, of course, there's no neuter, so the following are easy:]

Include (-
language Spanish

<adjective-to-plural> ::=
	*		0s

<adjective-to-masculine-singular> ::=
	*		0


[So the real work starts here: blanc to blancs, and so on.]

<adjective-to-masculine-plural> ::=
	... <adjective-to-plural>

<adjective-to-feminine-singular> ::=
	... <es-adjective-to-feminine-default>

<es-adjective-to-feminine-default> ::=
	*			1a

-) in the Preform grammar.

[---------------------------------------------------------------------------------------------]
[---------------------------------------------------------------------------------------------]
[---------------------------------------------------------------------------------------------]
Part 2.4 - Verbs

Chapter 2.4.1 - Verb conjugations

[Now we need to give instructions on how to conjugate verbs. See also the
published guide to Inform syntax, which goes through the English case; but
the French case below shows off features not needed for English, so it's a
better example to follow for other languages.]

[The specification below is not bad, but it does ignore a few grammatical
difficulties. Harmlessly, it constructs now obsolete forms for defective
verbs with some parts missing: French doesn't have many of these, but for
example, "poindre" lacks a past tense form in modern French. We'll construct
it anyway. Other gaps in our coverage will be marked >--> below; they might
need improving later.]

Include (-
language Spanish

[PRINCIPAL]
<verb-conjugation-instructions> ::=
  ser   <es-ser-conjugation> |
  estar   <es-estar-conjugation> |
[Regular -AR verbs]	
	-ar 		<es-ar-conjugation> 	[e.g., "cantar"]



[VERBO SER]
<es-ser-conjugation> ::=
  2		siendo |
  3		sido |	
  <es-ser-tabulation>

<es-ser-tabulation> ::=
  a1+  <es-ser-present> |
  a1-  no <es-ser-present> |
  a2+  <es-ser-past> |
  a2-  no <es-ser-past> |
  a5+  <es-ser-future> |
  a5-  no <es-ser-future>
  
<es-ser-present> ::=
  soy | eres | es | somos | sois | son
  
<es-ser-past> ::=
  fui | fuiste | fue | fuimos | fuisteis | fueron
  

<es-ser-future> ::=
  seré | serás | será | seremos | seréis| serán
 

[VERBO ESTAR]
<es-estar-conjugation> ::=
  2		estando |
  3		estado |	
  <es-estar-tabulation>

<es-estar-tabulation> ::=
  a1+  <es-estar-present> |
  a1-  no <es-estar-present> |
  a2+  <es-estar-past> |
  a2-  no <es-estar-past> |
  a5+  <es-estar-future> |
  a5-  no <es-estar-future>
  
<es-estar-present> ::=
  estoy | estas | está | estamos | estáis | están
  
<es-estar-past> ::=
  estuve | estuviste | estuvo | estuvimos | estuvisteis | estuvieron
  

<es-estar-future> ::=
  estará | estarás | estará | estaremos | estaréis| estarán
  
[VERBOS -AR  REGULARES SALTAR CANTAR CORTAR ETC]

<es-ar-conjugation> ::=
	5 <es-first-stem-general> |	[slot 5 we use for the stem of the verb]
	2 5+ando |			[present participle: stem + -ando, e.g., saltando]
	3 5+ado |					[past participle: stem + -i, e.g., cortado]
	<es-ar-conjugation-tabulation>

<es-first-stem-general> ::=
	*	2					[drop the last two letters: donner -> donn]

<es-ar-conjugation-tabulation> ::=
  a1+		<es-ar-present> |
	a1-		no <es-ar-present>  |
	a2+		<es-ar-past> |
	a2-		no <es-ar-past> |
	a5+		<es-ar-future> |
	a5-		no <es-ar-future>
	
<es-ar-present> ::=
	5+o | 5+as | 5+a | 5+amos | 5+áis | 5+an
	
<es-ar-past> ::=
	5+é | 5+aste | 5+ó | 5+amos | 5+asteis | 5+aron	

<es-ar-future> ::=
	5+aré | 5+arás | 5+ará | 5+aremos | 5+aréis | 5+arán


-) in the Preform grammar.


Chapter 2.4.2 - Meaningful verbs

Section 2.4.2.1 - In the Standard Rules

[We declare French equivalents of all meaningful verbs built into the
Standard Rules. This is mostly easy, but it's awkward that "porter" is
French both for "to carry" and "to wear", so that "Elle porte une robe"
could mean either "she carries a dress" or "she wears a dress"; I've
guessed that "porter" ought to mean "carry" here, and then provided
"elle est vétue de..." for "she is wearing...".]

In Spanish ser is a verb meaning to be.
In Spanish estar is a verb meaning to be.

[In Spanish tener is a verb meaning to have.
In Spanish estar relacionado is a verb meaning to relate.
In Spanish proveer is a verb meaning to provide.
In Spanish contener is a verb meaning to contain.
In Spanish suportar is a verb meaning to support.
In Spanish sostener is a verb meaning to support.
In Spanish incorporar is a verb meaning to incorporate.
In Spanish adjuntar is a verb meaning to enclose.
In Spanish llevar is a verb meaning to carry.
In Spanish porter is a verb meaning to wear.
In Spanish sostener is a verb meaning to hold.
In Spanish ocultar is a verb meaning to conceal.
In Spanish destrabar is a verb meaning to unlock.]

Section 2.4.2.2 - In Rideable Vehicles (for use with Rideable Vehicles by Graham Nelson)

In Spanish montar sobre is a verb meaning to mount.
In Spanish desmontar is a verb meaning to dismount.

Section 2.4.2.3 - In Locksmith (for use with Locksmith by Emily Short)

In Spanish destrancar is a verb meaning to unbolt.


Chapter 2.4.3 - Prepositions














Volume 3 - Responses

Part 3.1 - Responses

Chapter 3.1.1 - Responses in the Standard Rules

[And now the responses from this extension. You can get a full set of these by
trying out any English source text, e.g.,

	The Amphitheatre is a room.

and then typing the command:

	RESPONSES SET 1

This produces text which can be pasted in here before being translated. I'm
only going to translate two, just for example's sake.]

[Verbos sin significados, solo para el texto adaptativo]
In Spanish llevar is a verb.

Section 1 - Standard actions concerning the actor's possessions

[ Taking inventory ]
    print empty inventory rule response (A) is "No [llevas] nada.".
    print standard inventory rule response (A) is "[Tu] [llevas][plm]:[line break]".
    report other people taking inventory rule response (A) is "[The actor] consulta su inventario.".


[ Taking ]
    can't take yourself rule response (A) is "Siempre te tienes a ti mism[o noun].".
    can't take other people rule response (A) is "No creo que [al noun] le gustara[n noun].".
    can't take component parts rule response (A) is "[regarding the noun]Parece que es parte [del whole].".
    can't take people's possessions rule response (A) is "[regarding the noun]Parece que pertenece [al owner].".
    can't take items out of play rule response (A) is "[regarding the noun]No [esta noun] disponible[s noun].".
    can't take what you're inside rule response (A) is "Tienes que [if noun is a supporter]bajarte[otherwise]salirte[end if] primero.".
    can't take what's already taken rule response (A) is "Ya tienes [regarding the noun][the noun].".
    can't take scenery rule response (A) is "Difícilmente podrías llevarte eso.".
    can only take things rule response (A) is "No puedes llevarte eso.".
    can't take what's fixed in place rule response (A) is "[regarding the noun][The noun] está fij[o noun] en el sitio.".
[    use player's holdall to avoid exceeding carrying capacity rule response (A) is "(colocas [the transferred item] en [the current working sack] para hacer sitio)[command clarification break]".]
    can't exceed carrying capacity rule response (A) is "Ya llevas demasiadas cosas.".
    standard report taking rule response (A) is "Cogid[o noun].".
    standard report taking rule response (B) is "[The actor] toma [the noun].".


[ Removing it from ]
    can't remove what's not inside rule response (A) is "[regarding the noun]¡Pero si no está[n noun] ahí ahora!".
    can't remove from people rule response (A) is "[regarding the noun]Parece que pertenece [al owner].".


[ Dropping ]
    can't drop yourself rule response (A) is "No puedes hacer algo así.".
    can't drop body parts rule response (A) is "No puedes dejar una parte de ti.".
    can't drop what's already dropped rule response (A) is "[The noun] ya está[n noun] allí.".
    can't drop what's not held rule response (A) is "Para dejar[lo noun] deberías tener[lo noun].".
    can't drop clothes being worn rule response (A) is "(primero te quitas [the noun])[command clarification break]".
    can't drop if this exceeds carrying capacity rule response (A) is "No hay más lugar sobre [the receptacle].".
    can't drop if this exceeds carrying capacity rule response (B) is "No hay más lugar en [the receptacle].".
    standard report dropping rule response (A) is "Dejad[o noun].".
    standard report dropping rule response (B) is "[The actor] deja [the noun].".


[ Putting it on ]
[    can't put what's not held rule response (A) is "Necesitas tener [the noun] para poder poner [lo noun] donde sea.".][deprecated]
    can't put something on itself rule response (A) is "No puedes poner un objeto sobre sí mismo.".
    can't put onto what's not a supporter rule response (A) is "Poner cosas sobre [the second noun] no servirá de nada.".
    can't put clothes being worn rule response (A) is "(primero te [lo noun] quitas)[command clarification break]".
    can't put if this exceeds carrying capacity rule response (A) is "No queda sitio en [the second noun].".
    concise report putting rule response (A) is "Hecho.".
    standard report putting rule response (A) is "[if the actor is the player]Pones[otherwise][The actor] pone[end if] [the noun] sobre [the second noun].".


[ Inserting it into ]
    can't insert something into itself rule response (A) is "No puedes poner un objeto dentro de sí mismo.".
    can't insert into closed containers rule response (A) is "[The second noun] está[n noun] cerrad[o noun].".
    can't insert into what's not a container rule response (A) is "No se pueden meter cosas dentro [del second noun].".
    can't insert clothes being worn rule response (A) is "(primero te [lo noun] quitas)[command clarification break]".
    can't insert if this exceeds carrying capacity rule response (A) is "No queda sitio en [the second noun].".
    concise report inserting rule response (A) is "Hecho.".
    standard report inserting rule response (A) is "[if the actor is the player]Pones[otherwise][The actor] pone[end if] [the noun] dentro [del second noun].".


[ Eating ]
    can't eat unless edible rule response (A) is "Eso es simplemente incomestible.".
    can't eat clothing without removing it first rule response (A) is "(primero te quitas [the noun])[command clarification break]".
    can't eat other people's food rule response (A) is "[Al owner] puede que no le guste.".
    standard report eating rule response (A) is "Te comes [the noun]. No está[n noun] mal.".
    standard report eating rule response (B) is "[The actor] se come [the noun].".


Section 2 - Standard actions which move the actor
[Going , Entering , Exiting , Getting off]

[ Going ]
    stand up before going rule response (A) is "(saliendo primero de [the chaise])[command clarification break]".
    can't travel in what's not a vehicle rule response (A) is "Tienes que bajarte [del nonvehicle] primero.".
    can't travel in what's not a vehicle rule response (B) is "Tienes que salirte [del nonvehicle] primero.".
    can't go through undescribed doors rule response (A) is "No puedes ir por ahí.".
    can't go through closed doors rule response (A) is "(abriendo primero [the door gone through])[command clarification break]".
    can't go that way rule response (A) is "No puedes ir por ahí.".
    can't go that way rule response (B) is "No puedes ir porque [the door gone through] no lleva a ningún sitio.".
    describe room gone into rule response (A) is "[The actor] se va hacia arriba".
    describe room gone into rule response (B) is "[The actor] se va hacia abajo".
    describe room gone into rule response (C) is "[The actor] se va hacia [noun]".
    describe room gone into rule response (D) is "[The actor] llega desde arriba".
    describe room gone into rule response (E) is "[The actor] llega desde abajo".
   [ describe room gone into rule response (F) is "[The actor] llega desde [the back way]".] [todo: no compila esto]
    describe room gone into rule response (G) is "[The actor] llega".
    [describe room gone into rule response (H) is "[The actor] llega a [the room gone to] desde arriba".[todo: no compila esto]
    describe room gone into rule response (I) is "[The actor] llega a [the room gone to] desde abajo"..
    describe room gone into rule response (J) is "[The actor] llega a [the room gone to] desde [the back way]".]
    describe room gone into rule response (K) is "[The actor]  se va por [the noun]".
    describe room gone into rule response (L) is "[The actor] llega desde [the noun]".
    describe room gone into rule response (M) is "sobre [the vehicle gone by]".
    describe room gone into rule response (N) is "en [the vehicle gone by]".
    describe room gone into rule response (O) is ", llevando [the thing gone with] en frente, y a ti también".
    describe room gone into rule response (P) is ", llevando [the thing gone with] en frente".
    describe room gone into rule response (Q) is ", llevando [the thing gone with] ".
    describe room gone into rule response (R) is ", llevando [the thing gone with] en".
    describe room gone into rule response (S) is ", llevándote a ti también".


[ Entering ]
    can't enter what's already entered rule response (A) is "Pero si ya estás sobre [the noun].".
    can't enter what's already entered rule response (B) is "Pero si ya estás en [the noun].".
[    can't enter what's not enterable rule response (A) is "No es algo donde puedas stand on.".
    can't enter what's not enterable rule response (B) is "[regarding the noun][They're] not something [we] [can] sit down on.".
    can't enter what's not enterable rule response (C) is "[regarding the noun][They're] not something [we] [can] lie down on.".]
    can't enter what's not enterable rule response (D) is "No es algo donde puedas entrar.".
    can't enter closed containers rule response (A) is "No puedes entrar en [the noun] porque está[n noun] cerrad[o noun].".
    can't enter something carried rule response (A) is "No puedes entrar ahí mientras no lo sueltes.".
    implicitly pass through other barriers rule response (A) is "(te bajas [del holder of the actor])[command clarification break]".
    implicitly pass through other barriers rule response (B) is "(sales [del holder of the actor])[command clarification break]".
    implicitly pass through other barriers rule response (C) is "(te subes [al target])[command clarification break]".
    implicitly pass through other barriers rule response (D) is "(te metes en [the target])[command clarification break]".
    implicitly pass through other barriers rule response (E) is "(entras en [the target])[command clarification break]".
    standard report entering rule response (A) is "Te subes [al noun].".
    standard report entering rule response (B) is "Entras en [the noun].".
    standard report entering rule response (C) is "[if the actor is the player]Entras[otherwise][The actor] entra[end if] en [the noun].".
    standard report entering rule response (D) is "[if the actor is the player]Subes[otherwise][The actor] sube[end if] [al noun].".
    

[ Exiting ]
    can't exit when not inside anything rule response (A) is "No estás en ningún sitio del que debas salir.".
    can't exit closed containers rule response (A) is "No puedes salir [del cage] porque está cerrad[o cage].".
    standard report exiting rule response (A) is "Bajas [del container exited from].".
    standard report exiting rule response (B) is "Sales [del container exited from].".
    standard report exiting rule response (C) is "[if the actor is the player]Sales[otherwise][The actor] sale[end if] [del container exited from].".


[ Getting off ]
    can't get off things rule response (A) is "Pero si no estás en [the noun].".
    standard report getting off rule response (A) is "[if the actor is the player]Sales[otherwise][The actor] sale[end if] [del noun].".


Section 3 - Standard actions concerning the actor's vision
[Looking , Examining , Looking under , Searching , Consulting it about ]

[ Looking ]
    room description heading rule response (A) is "Oscuridad".
    room description heading rule response (B) is " (sobre [the intermediate level])".
    room description heading rule response (C) is " (en [the intermediate level])".
    room description body text rule response (A) is "Está muy oscuro y no puedes ver nada.".
    other people looking rule response (A) is "[The actor] mira alrededor.".


[ Examining ]
    examine directions rule response (A) is "No ves nada en especial al mirar en esa dirección.".
    examine containers rule response (A) is "En [the noun] ".
    examine containers rule response (B) is "[The noun] está[n noun] vací[o noun].".
    examine supporters rule response (A) is "Sobre [the noun] ".
    examine devices rule response (A) is "[The noun] está[n noun] [if the noun is switched on]encendid[o noun][otherwise]apagad[o noun][end if].".
    examine undescribed things rule response (A) is "No observas nada especial en [the noun].".
    report other people examining rule response (A) is "[The actor] mira de cerca [al noun].".


[ Looking under ]
    standard looking under rule response (A) is "No ves nada interesante.".
    report other people looking under rule response (A) is "[The actor] mira debajo [del noun].".


[ Searching ]
    can't search unless container or supporter rule response (A) is "No encuentras nada interesante.".
    can't search closed opaque containers rule response (A) is "No puedes ver lo que hay dentro [del noun] porque está[n noun] cerrado[s noun].".
    standard search containers rule response (A) is "En [the noun] ".
    standard search containers rule response (B) is "[The noun] está[n noun] vací[o noun].".
    standard search supporters rule response (A) is "Sobre [the noun] ".
    standard search supporters rule response (B) is "No hay nada sobre [the noun].".
    report other people searching rule response (A) is "[The actor] busca [al noun].".


[ Consulting it about ]
    block consulting rule response (A) is "No descubres nada interesante en [the noun] sobre este tema.".
    block consulting rule response (B) is "[The actor] consulta [the noun].".


Section 4 - Standard actions which change the state of things
[Locking it with , Unlocking it with , Switching on , Switching off , Opening , Closing , Wearing , Taking off ]


[ Locking it with ]
    can't lock without a lock rule response (A) is "[regarding the noun]No parece[n noun] tener ningún tipo de cerrojo.".
    can't lock what's already locked rule response (A) is "[regarding the noun][The noun] ya estaba cerrad[o noun].".
    can't lock what's open rule response (A) is "Primero tendrás que cerrar [the noun].".
    can't lock without the correct key rule response (A) is "[regarding the second noun]No parece[n second noun], encajar en la cerradura.".
    standard report locking rule response (A) is "Cierras [the noun].".
    standard report locking rule response (B) is "[The actor] cierra [the noun].".


Standard report waiting rule response (A) is "El tiempo pasa...".



Section 8 - Standard actions which happen out of world
[Quitting the game , Saving the game , Restoring the game , Restarting the game , Verifying the story file , Switching the story transcript on , Switching the story transcript off , Requesting the story file version , Requesting the score , Preferring abbreviated room descriptions , Preferring unabbreviated room descriptions , Preferring sometimes abbreviated room descriptions , Switching score notification on , Switching score notification off , Requesting the pronoun meanings ]

[Quitting the game ]
	quit the game rule response (A) is "¿Seguro que quieres abandonar el juego? ".
	

[ Saving the game ]
	save the game rule response (A) is "Error. No se pudo guardar.".
	save the game rule response (B) is "Ok.".


[ Restoring the game ]
	restore the game rule response (A) is "Error. No se pudo recuperar la partida.".
	restore the game rule response (B) is "Ok.".


[ Restarting the game ]
	restart the game rule response (A) is "¿Seguro que quieres reiniciar el juego? ".
	restart the game rule response (B) is "Error.".


[ Verifying the story file ]
	verify the story file rule response (A) is "Fichero de juego verificado e intacto.".
	verify the story file rule response (B) is "El fichero de juego no parece intacto, puede estar corrompido (a menos que estés jugando con un intérprete muy primitivo que no sea capaz de realizar la comprobación).".


Part 3.2 - The Final Question

Table of Final Question Options (replaced)
final question wording	only if victorious	topic		final response rule		final response activity
"REINICIAR"				false				"reiniciar"	immediately restart the VM rule	--
"RECUPERAR un juego guardado"	false				"recuperar"	immediately restore saved game rule	--
"ver algunas CURIOSIDADES"	true	"curiosidades"	--	amusing a victorious player
"TERMINAR"					false				"terminar"		immediately quit rule	--
"hacer UNDO del último comando"		false				"undo"		immediately undo rule	--


Part 3.3 - Activities Rules Spanish Replacement
[Spanish-output replacement for some Activities from Standar Rules]

[Chapter 1 How commands are understood]

[ supplying a missing noun ]
block vaguely going rule response (A) is "Debes especificar en qué dirección ir.".

[ implicitly taking]
standard implicit taking rule response (A) is "(primero coges [the noun])[command clarification break]".
standard implicit taking rule response (B) is "([the second noun] primero coge [the noun])[command clarification break]".


[Chapter 2 How things are described]

[ printing the locale description]
you-can-also-see rule response (A) is "Puedes ".
you-can-also-see rule response (B) is "Sobre [the domain] puedes ".
you-can-also-see rule response (C) is "En [the domain] puedes ".
you-can-also-see rule response (D) is "ver también ".
you-can-also-see rule response (E) is "ver ".
you-can-also-see rule response (F) is " aquí".

[ printing a locale paragraph about]
use initial appearance in room descriptions rule response (A) is "Sobre [the item] ".
describe what's on scenery supporters in room descriptions rule response (A) is "Sobre [the item] ".



[chapter 3 How accessibility is judged]

[ reaching inside]
can't reach inside rooms rule response (A) is "No llegas a [the noun].".
can't reach inside closed containers rule response (A) is "[The noun] no está abierto.".
can't reach outside closed containers rule response (A) is "[The noun] no está abierto.". 



[Chapter 4 The top level]

[ turn sequence rules]
generate action rule response (A) is "(solo considero los primeros dieciséis objetos)[command clarification break]".
generate action rule response (B) is "¡Nada para hacer!".
adjust light rule response (A) is "¡Está muy oscuro aquí!".

[ printing the player's obituary ]
print obituary headline rule response (A) is " Has muerto ".
print obituary headline rule response (B) is " Has ganado ".
print obituary headline rule response (C) is " Fin ".


[ handling the final question ]
print the final question rule response (A) is "¿Quieres ".
print the final question rule response (B) is " o ".
standard respond to final question rule response (A) is "por favor, responde a alguna de arriba.".



[Chapter 5 How actions are processed  ]

[ action-processing rules ]
basic visibility rule response (A) is "Está demasiado oscuro, no puedes ver nada.".
basic accessibility rule response (A) is "Debes decir algo más... concreto.".
requested actions require persuasion rule response (A) is "[The noun] tiene mejores cosas que hacer.".
carry out requested actions rule response (A) is "[The noun] no puede hace eso.".


[Chapter 6  List writer internal rule	]
    list writer internal rule response (A) is " (".
    list writer internal rule response (B) is ")".
    list writer internal rule response (C) is " y ".
    list writer internal rule response (D) is "alumbrando".
    list writer internal rule response (E) is "cerrado [o noun]".
    list writer internal rule response (F) is "vací[o noun]".
    list writer internal rule response (G) is "cerrado [o noun] y vací[o noun]".
    list writer internal rule response (H) is "cerrado [o noun] y alumbrando".
    list writer internal rule response (I) is "vacío [o noun] y alumbrando".
    list writer internal rule response (J) is "cerrado [o noun], vacío [o noun][if serial comma option is active],[end if] y alumbrando".
    list writer internal rule response (K) is "(alumbrando y que llevas puest [o noun]".
    list writer internal rule response (L) is "que llevas puest [o noun]".
    list writer internal rule response (M) is "abiert[o noun]".
    list writer internal rule response (N) is "abiert[o noun] y vací[o noun]".
    list writer internal rule response (O) is "cerrado [o noun]".
    list writer internal rule response (P) is "cerrado [o noun] con llave".
    list writer internal rule response (Q) is "que contiene".
    list writer internal rule response (R) is " ([if the noun is a person]encima [del_ noun][otherwise]sobre [el_ noun][end if]cual[s noun] ".
    list writer internal rule response (S) is ", [if the noun is a person]encima[otherwise]sobre[end if] del cual".
    list writer internal rule response (T) is " (in [if the noun is a person]whom[otherwise]which[end if] ".
    list writer internal rule response (U) is ", dentro ".
    list writer internal rule response (V) is "ves".
    list writer internal rule response (W) is "es nada".
    list writer internal rule response (X) is "Nada".
    list writer internal rule response (Y) is "nada".


[Chapter 7 - Action processing internal rule]
    action processing internal rule response (A) is "[bracket]Esa orden se aplica fuera del juego, por lo que solo tiene sentido para el parser, no para [the noun].[close bracket]".
    action processing internal rule response (B) is "Debes mencionar un objeto en concreto".
    action processing internal rule response (C) is "No es necesario mencionar un objeto.".
    action processing internal rule response (D) is "Debes mencionar un objeto en concreto".
    action processing internal rule response (E) is "No es necesario mencionar un objeto.".
    action processing internal rule response (F) is "Debes mencionar el segundo objeto en concreto.".
    action processing internal rule response (G) is "Puedes no mencionar el segundo objeto.".
    action processing internal rule response (H) is "Debes mencionar el segundo objeto en concreto.".
    action processing internal rule response (I) is "Puedes no mencionar el segundo objeto.".
    action processing internal rule response (J) is "(Ya que ha ocurrido algo dramático, se ha recortado la lista de objetos sobre los que actuabas)".
    
    
[Chapter 8 - Parser error internal rule]
    parser error internal rule response (A) is "No entendí esa frase.".
    parser error internal rule response (B) is "Intenta de nuevo, porque sólo te pude entender: ".
    parser error internal rule response (C) is "Intenta de nuevo, porque sólo te pude entender: (IR) ".    
    parser error internal rule response (D) is "No comprendí ese número.".
    parser error internal rule response (E) is "No veo eso que dices.".
    parser error internal rule response (F) is "¡Pareces haber dicho muy poca cosa!".
    parser error internal rule response (G) is "¡No tienes eso!".    
    parser error internal rule response (H) is "No puedes especificar objetos múltiples con ese verbo.".
    parser error internal rule response (I) is "Sólo puedes especificar objetos múltiples una vez en cada línea.".
    parser error internal rule response (J) is "No estoy seguro de a qué se refiere ['][pronoun i6 dictionary word]['].".
    parser error internal rule response (K) is "Ahora mismo no puedes ver lo que representa el pronombre ['][pronoun i6 dictionary word]['] ([the noun]).".    
    parser error internal rule response (L) is "Has exceptuado algo que no estaba incluido.".
    parser error internal rule response (M) is "Sólo puedes hacer eso con seres animados.".
    parser error internal rule response (N) is "No conozco ese verbo.".
    parser error internal rule response (O) is "Eso no es importante.".
    parser error internal rule response (P) is "No entendí la última parte de la orden.".
    parser error internal rule response (Q) is "[if number understood is 0]No hay suficientes.[otherwise]Aquí sólo hay [number understood] disponible.[end if]".
    parser error internal rule response (R) is "Ese objeto no tiene sentido en este contexto.".
    parser error internal rule response (S) is "Para repetir un comando como 'rana, salta', escribe 'repite', en lugar de 'rana, repite'.".
    parser error internal rule response (T) is "No puedes empezar la frase con una coma.".
    parser error internal rule response (U) is "Parece que quieres hablar con alguien, pero no veo con quién.".
    parser error internal rule response (V) is "No puedes hablar con [the noun].".
    parser error internal rule response (W) is "Para hablar con alguien intenta 'alguien, hola' o algo así.".
    parser error internal rule response (X) is "¿Perdón?".

[    
    parser error internal rule response (Q) is "¡No encuentro nada para hacer eso!".
    parser error internal rule response (R) is "No hay ninguno disponible.".
    parser error internal rule response (T) is "Eso parece partenecer a [the noun].".
    parser error internal rule response (U) is "Eso no puede contener cosas.".
    parser error internal rule response (V) is "[The noun] está cerrado.".
    parser error internal rule response (X) is "[The noun] está vacío.".
] [deprecated?]

 
[Section  13 - Darkness name internal rule]
    darkness name internal rule response (A) is "Oscuridad".


[Section  14 - Parser command internal rule]
    parser command internal rule response (A) is "Lo siento, eso no puede corregirse.".
    parser command internal rule response (B) is "No te preocupes.".
    parser command internal rule response (C) is "'eepa' sólo puede corregir una palabra.".
    parser command internal rule response (D) is "No hay commando que repetir.".
    

[Section  15 - Parser clarification internal rule]
    parser clarification internal rule response (A) is "¿Quién concretamente ".
    parser clarification internal rule response (B) is "¿Cuál concretamente, ".
    parser clarification internal rule response (C) is "Lo siento, sólo puedes referirte a un objeto aquí. ¿Cuál exactamente?".
    parser clarification internal rule response (D) is "¿A quién [if the noun is not the player][the noun] tiene que [otherwise]quieres [end if] [parser command so far]?".
    parser clarification internal rule response (E) is "¿Qué [if the noun is not the player][the noun] tiene que[otherwise]quieres[end if] [parser command so far]?".
    parser clarification internal rule response (F) is "esas cosas".
    parser clarification internal rule response (G) is "eso".
    parser clarification internal rule response (H) is " o ".


[Section  16 - Yes or no question internal rule]
    yes or no question internal rule response (A) is "Por favor responde sí o no.".

[Section  17 - Print protagonist internal rule]
    print protagonist internal rule response (A) is "[We]".
    print protagonist internal rule response (B) is "[ourselves]".
    print protagonist internal rule response (C) is "[our] anterior tú".

[Section  18 - Standard implicit taking rule]
    standard implicit taking rule response (A) is "(primero coge [the noun])[command clarification break]".
    standard implicit taking rule response (B) is "([the second noun] primero coge [the noun])[command clarification break]".

[Section  20 - Immediately undo rule]
    immediately undo rule response (A) is "El uso de 'deshacer' no está permitido en este juego.".
    immediately undo rule response (B) is "No puedes 'deshacer' lo que no has hecho.".
    immediately undo rule response (C) is "Tu intérprete no puede 'deshacer' acciones, ¡lo siento!".
    immediately undo rule response (D) is "No puedes 'deshacer' más.".
    immediately undo rule response (E) is "[bracket]Retrocediendo al turno anterior.[close bracket]".



Volume 4 - Command parsing

Part 4.1 - Pronouns and possessives in commands

[This is taken straight from Eric Fourgeot's "French"; nothing has changed.]

Include (-
Array LanguagePronouns table

!   palabra  GNAs que pueden                conectado
!            seguirle:                      a:
!              a     i
!              s  p  s  p
!              mfnmfnmfnmfn

    '-lo'	$$101000100001                    NULL
    '-los'	$$000101000101                    NULL
    '-la'	$$010000010000                    NULL
    '-las'	$$000010000010                    NULL
    '-le'	$$110000110000                    NULL
    '-les'	$$000110000110                    NULL
    'él'		$$100000100000                    NULL
    'ella'	$$010000010000                    NULL
    'ellos'	$$000100000100                    NULL
    'ellas'	$$000010000010                    NULL;
-) instead of "Pronouns" in "Language.i6t".

Include (-
Array LanguageDescriptors table

    !palabra  GNAs que pueden     tipo de   conectado
    !              seguirles:	  descriptor:       con:
    !          a     i
    !          s  p  s  p
    !          mfnmfnmfnmfn                 
    
    'mi'	$$110110110110    POSSESS_PK      0
!    'este'	$$100000100000    POSSESS_PK      0 ! Mel Hython: para evitar problemas con direccion 'este'
    'estos'	$$000100000100    POSSESS_PK      0
    'esta'	$$010000010000    POSSESS_PK      0
    'estas'	$$000010000010    POSSESS_PK      0
    'ese'	$$100000100000    POSSESS_PK      1
    'esa'	$$010000010000    POSSESS_PK      1
    'esos'	$$000100000100    POSSESS_PK      1
    'esas'	$$000010000010    POSSESS_PK      1
    'su'	$$110000110000    POSSESS_PK      '-le'
    'sus'	$$000110000110    POSSESS_PK      '-le'
    'el'	$$100000100000    DEFART_PK       NULL
    'la'	$$010000010000    DEFART_PK       NULL
    'los'	$$000100000100    DEFART_PK       NULL
    'las'	$$000010000010    DEFART_PK       NULL
    'un'	$$100000100000    INDEFART_PK     NULL
    'una'	$$010000010000    INDEFART_PK     NULL
    'unos'	$$000100000100    INDEFART_PK     NULL
    'unas'	$$000010000010    INDEFART_PK     NULL
    'algún'	$$100000100000    INDEFART_PK     NULL
   'algunos' $$000100000100    INDEFART_PK     NULL
   'algunas' $$000010000010    INDEFART_PK     NULL
 'encendido' $$100000100000    light             NULL
 'encendida' $$010000010000    light             NULL
'encendidos' $$000100000100    light             NULL
'encendidas' $$000010000010    light             NULL
   'apagado' $$100000100000    (-light)          NULL
   'apagada' $$010000010000    (-light)          NULL
  'apagados' $$000100000100    (-light)          NULL
  'apagadas' $$000010000010    (-light)          NULL;
-) instead of "Descriptors" in "Language.i6t".

Part 4.2 - Understand grammar

Part 4.2.1 - Replacing English verbs

[ Propósito: Para no incluir el bloque de gramaticas (y verbos) ingleses en el fuente (optimiza memoria)]
[               Si deseas mantener alguno, solo comenta la linea correspondiente]

Understand the command "take" as something new.
Understand the command "carry" as something new.
Understand the command "hold" as something new.
Understand the command "get" as something new.
Understand the command "pick" as something new.
Understand the command "stand" as something new.
Understand the command "remove" as something new.
Understand the command "shed" as something new.
Understand the command "doff" as something new.
Understand the command "disrobe" as something new.
Understand the command "don" as something new.
Understand the command "wear" as something new.
Understand the command "put" as something new.
Understand the command "drop" as something new.
Understand the command "throw" as something new.
Understand the command "discard" as something new.
Understand the command "give" as something new.
Understand the command "pay" as something new.
Understand the command "offer" as something new.
Understand the command "feed" as something new.
Understand the command "present" as something new.
Understand the command "display" as something new.
Understand the command "show" as something new.
Understand the command "go" as something new.
Understand the command "walk" as something new.
Understand the command "leave" as something new.
Understand the command "run" as something new.
Understand the command "inventory" as something new.
Understand the command "i" as something new.
Understand the command "inv" as something new.
Understand the command "look" as something new.
Understand the command "l" as something new.
Understand the command "consult" as something new.
Understand the command "open" as something new.
Understand the command "unwrap" as something new.
Understand the command "uncover" as something new.
Understand the command "shut" as something new.
Understand the command "cover" as something new.
Understand the command "close" as something new.
Understand the command "cross" as something new.
Understand the command "enter" as something new.
Understand the command "sit" as something new.
Understand the command "exit" as something new.
Understand the command "out" as something new.
Understand the command "x" as something new.
Understand the command "watch" as something new.
Understand the command "describe" as something new.
Understand the command "check" as something new.
Understand the command "examine" as something new.
Understand the command "read" as something new.
Understand the command "yes" as something new.
Understand the command "y" as something new.
Understand the command "yes" as something new.
Understand the command "no" as something new.
Understand the command "sorry" as something new.
Understand the command "shit" as something new.
Understand the command "fuck" as something new.
Understand the command "damn" as something new.
Understand the command "bother" as something new.
Understand the command "curses" as something new.
Understand the command "drat" as something new.
Understand the command "darn" as something new.
Understand the command "search" as something new.
Understand the command "wave" as something new.
Understand the command "adjust" as something new.
Understand the command "set" as something new.
Understand the command "drag" as something new.
Understand the command "pull" as something new.
Understand the command "push" as something new.
Understand the command "move" as something new.
Understand the command "shift" as something new.
Understand the command "clear" as something new.
Understand the command "press" as something new.
Understand the command "rotate" as something new.
Understand the command "twist" as something new.
Understand the command "unscrew" as something new.
Understand the command "screw" as something new.
Understand the command "turn" as something new.
Understand the command "switch" as something new.
Understand the command "lock" as something new.
Understand the command "unlock" as something new.
Understand the command "attack" as something new.
Understand the command "break" as something new.
Understand the command "smash" as something new.
Understand the command "hit" as something new.
Understand the command "fight" as something new.
Understand the command "torture" as something new.
Understand the command "wreck" as something new.
Understand the command "crack" as something new.
Understand the command "destroy" as something new.
Understand the command "murder" as something new.
Understand the command "kill" as something new.
Understand the command "punch" as something new.
Understand the command "thump" as something new.
Understand the command "wait" as something new.
Understand the command "z" as something new.
Understand the command "answer" as something new.
Understand the command "say" as something new.
Understand the command "shout" as something new.
Understand the command "speak" as something new.
Understand the command "tell" as something new.
Understand the command "ask" as something new.
Understand the command "eat" as something new.
Understand the command "sleep" as something new.
Understand the command "nap" as something new.
Understand the command "sing" as something new.
Understand the command "climb" as something new.
Understand the command "scale" as something new.
Understand the command "purchase" as something new.
Understand the command "buy" as something new.
Understand the command "squeeze" as something new.
Understand the command "swim" as something new.
Understand the command "dive" as something new.
Understand the command "swing" as something new.
Understand the command "blow" as something new.
Understand the command "pray" as something new.
Understand the command "wake" as something new.
Understand the command "awake" as something new.
Understand the command "awaken" as something new.
Understand the command "kiss" as something new.
Understand the command "embrace" as something new.
Understand the command "hug" as something new.
Understand the command "think" as something new.
Understand the command "sniff" as something new.
Understand the command "smell" as something new.
Understand the command "listen" as something new.
Understand the command "hear" as something new.
Understand the command "feel" as something new.
Understand the command "touch" as something new.
Understand the command "rub" as something new.
Understand the command "shine" as something new.
Understand the command "polish" as something new.
Understand the command "sweep" as something new.
Understand the command "clean" as something new.
Understand the command "dust" as something new.
Understand the command "wipe" as something new.
Understand the command "scrub" as something new.
Understand the command "attach" as something new.
Understand the command "fix" as something new.
Understand the command "tie" as something new.
Understand the command "light" as something new.
Understand the command "burn" as something new.
Understand the command "swallow" as something new.
Understand the command "sip" as something new.
Understand the command "drink" as something new.
Understand the command "fill" as something new.
Understand the command "slice" as something new.
Understand the command "prune" as something new.
Understand the command "chop" as something new.
Understand the command "cut" as something new.
Understand the command "jump" as something new.
Understand the command "skip" as something new.
Understand the command "hop" as something new.
Understand the command "dig" as something new.
Understand the command "score" as something new.
Understand the command "quit" as something new.
Understand the command "q" as something new.
Understand the command "save" as something new.
Understand the command "restart" as something new.
Understand the command "restore" as something new.
Understand the command "verify" as something new.
Understand the command "version" as something new.
Understand the command "script" as something new.
Understand the command "transcript" as something new.
Understand the command "superbrief" as something new.
Understand the command "short" as something new.
Understand the command "verbose" as something new.
Understand the command "long" as something new.
Understand the command "brief" as something new.
Understand the command "normal" as something new.
Understand the command "nouns" as something new.
Understand the command "pronouns" as something new.
Understand the command "notify" as something new.
Understand the command "insert" as something new.
Understand the command "purchase" as something new.
Understand the command "squash" as something new.
Understand the command "taste" as something new.
Understand the command "fasten" as something new.


Part 4.2.2 - Actions

[Old I6 Grammar.h file is dumped here, using I7 language]

[ Gramatica basada en InformATE! (I6) (by Zak)]
[ Verbos irregulares: filosofia usada en informATE!]
[ Para algunas acciones no estan permitidas ciertas variantes de la gramatica de informATE, como el uso de second noun como token.
  esto hace la respuesta del parser mucho mas tonta: Ej, corta el pan o corta el pan con el cuchillo. ToDo: podrá resolverse esto?]

Part 4.2.2.1 - Grammar for Actions in the Game World

Understand "toma [things]" as taking. Understand the commands "coge" and "recoge" as "toma".
Understand "toma a [someone]" as taking.
Understand "toma [things inside] de [something]" as removing it from.

Understand "saca [things inside] de [something]" as removing it from.
Understand "saca a [someone] de [something]" as removing it from.

Understand "quita [things inside] de [something]" as removing it from.
Understand "quita a [someone] de [something]" as removing it from.
Understand "quita [things inside] a [something]" as removing it from.
Understand the command "quitale" as "quita".


[Understand "quita cerrojo/pestillo/cierre a [something]" as unlocking it with.] [TODO Unlock no soporta call sin segundo argumento 'second noun' y dice: 'You must supply a second noun.'] 
[Understand "quita el cerrojo/pestillo/cierre a [something]" as unlocking it with.]
Understand "quita cerrojo/pestillo/cierre a [something] con [something preferably held]" as unlocking it with. 
Understand "quita el cerrojo/pestillo/cierre a [something] con [something preferably held]" as unlocking it with.

Understand "sacate [something preferably held]" as taking off. Understand the commands "quitate","sacarse","quitarse","quitarte","sacarte","sacarme","quitarme","quitame" and "sacame" as "sacate".

Understand "ponte [something preferably held]" as wearing.
Understand "ponte con [something preferably held]" as wearing.
Understand the commands  "viste","vistete","ponerse","vestirse","ponerte","vestirte","ponerme","vestirme","ponme" and "visteme" as "ponte".

Understand "pon [other things] en [container]" as inserting it into. Understand the commands  "mete","echa","inserta" and "coloca"  as "pon".
Understand "pon [other things] en/sobre [something]" as putting it on. 
Understand "pon [other things] dentro de [something]" as inserting it into.
Understand "pon [something] a [text]" as setting it to.
Understand "pon a [someone] en [container]" as inserting it into.
Understand "pon a [someone] en [something]" as putting it on.
Understand "pon a [someone] dentro de [something]" as inserting it into.[todo no seria [container]?]
Understand "pon a [someone] sobre [something]" as putting it on. 
Understand "pon [other things] encima de [something]" as putting it on.
Understand "pon a [someone] encima de [something]" as putting it on.

Understand "pon cerrojo/pestillo/cierre a [something]" as locking it with.
Understand "pon el cerrojo/pestillo/cierre a [something]" as locking it with.
Understand "pon cerrojo/pestillo/cierre a [something] con [something preferably held]" as locking it with.
Understand "pon el cerrojo/pestillo/cierre a [something] con [something preferably held]" as locking it with.

Understand "deja [things preferably held]" as dropping. Understand the command "suelta" as "deja".
Understand "deja a [someone]" as dropping.
Understand "deja [other things] en [container]" as inserting it into.
Understand "deja [other things] en/sobre [something]" as putting it on.
Understand "deja [other things] dentro de [something]" as inserting it into.
Understand "deja [other things] encima de [something]" as putting it on.

Understand "lanza [something preferably held] a/por/contra [something]" as throwing it at. Understand the command "arroja" as "lanza". 
Understand "lanza a [someone] por/contra [something]" as throwing it at.

Understand "tira de [something]" as pulling.
Understand "tira [things preferably held]" as dropping.
Understand "tira a [things preferably held]" as dropping. [added]
Understand "tira [other things] en [container]" as inserting it into.
Understand "tira [other things] en/sobre [something]" as putting it on.
Understand "tira [other things] dentro de [something]" as inserting it into.
Understand "tira [other things] encima de [something]" as putting it on.
Understand "tira [something preferably held] a/contra [something]" as throwing it at.
Understand "tira [things preferably held] por [something]" as inserting it into. 

Understand "da [something preferably held] a [someone]" as giving it to.
Understand "da a [someone] [something preferably held]" as giving it to (with nouns reversed).
Understand "da [someone] [something preferably held]" as giving it to (with nouns reversed).
Understand "da una patada a [something]" as attacking.
Understand "da un punetazo a [something]" as attacking.
Understand "da un golpe a [something]" as attacking.
Understand the commands   "regala","dale","dase","ofrece" and "darse" as "da".

Understand "muestra [someone] [something preferably held]" as showing it to (with nouns reversed). Understand the command "ensena" as "muestra".
Understand "muestra a [someone] [something preferably held]" as showing it to (with nouns reversed).
Understand "muestra [something preferably held] a [someone]" as showing it to.

Understand "vete" as going. [TODO produce texto: You'll have to say which compass direction to go in. Esto reemplazaria la accion VagueGo. Traducir]
Understand "vete [direction]" as going. Understand the commands  "ve","camina","anda","corre","vuelve" and "ir" as "vete".
Understand "vete a/hacia [direction]" as going.
Understand "vete [something]" as entering.
Understand "vete a/hacia/por [something]" as entering.

Understand "pasa por [something]" as entering.

Understand "inventario" as taking inventory. Understand the commands "inv" and "i" as "inventario". [todo: falta el 'breve'/'estrecho'] 

Understand "look" as looking. Understand the commands "mira","m","l" and "ver" as "look".
Understand "look a [someone]" as examining.
Understand "look [something]" as examining.
Understand "look a/hacia [something]" as examining. [for compass]
Understand "look en/sobre/por [something]" as searching.
Understand "look dentro de [something]" as searching.
Understand "look bajo [something]" as looking under.
Understand "look debajo de [something]" as looking under.
Understand "look a traves de [something]" as searching.

Understand "consulta [someone] sobre [text]" as asking it about.
Understand "consulta a [someone] sobre [text]" as asking it about.
Understand "consulta sobre [text] a [someone]" as asking it about (with nouns reversed).
Understand "consulta [something] sobre [text]" as consulting it about.
Understand "consulta [something] acerca de [text]" as consulting it about.
Understand "consulta [text] en [something]" as consulting it about (with nouns reversed).

Understand "abre [something]" as opening.
Understand "abre a [someone]" as opening.
Understand "abre [something] con [something preferably held]" as unlocking it with.

Understand "cierra [something]" as closing.
Understand "cierra [something] con pestillo" as locking it with.
Understand "cierra [something] con [something preferably held]" as locking it with.

Understand "destapa [something]" as opening. Understand the command "descubre" as "destapa".

Understand "tapa [something]" as closing. Understand the command "cubre" as "tapa".

Entering to room is an action applying to nothing.
The specification of the entering to room action is "Esta acción se ejecuta con el comando
'entra', asumiendo que en realidad se quiere entrar a alguna localidad que se tenga enfrente, y que en
el juego esté correctamente mapeada de manera que corresponda al 'inside' de la localidad actual.".
Carry out entering to room (this is the intentar entrar rule): try going inside.

Understand "entra" as entering to room.

Understand "entra en/por/a [something]" as entering. Understand the command "cruza" as "entra".
Understand "entra [something]" as entering.
Understand "entra dentro de [something]" as entering.

Understand "metete en/por [something]" as entering. Understand the commands "meterse","meterte","meterme" and "meteme" as "metete".

Understand "atraviesa [something]" as entering.

Understand "sienta en [something]" as entering. Understand the commands "echate","sientate","echarse","sentarse","echarte" and "sentarte" as "sienta".

Understand "sal" as exiting.
Understand "sal de [something]" as getting off.
[Understand "sal por [something]" as entering.] [comentariado en informate]
Understand "sal fuera/afuera" as exiting. Understand the commands "fuera","afuera","salte","bajate","levantate","bajarse","levantarse","salirse","bajarte","levantarte" and "salirte" as "sal".

Understand "examina [something]" as examining.
Understand "examina a [someone]" as examining. Understand the commands  "describe","inspecciona","observa","ex","x" as "examina".

Understand "lee [something]" as examining.
Understand "lee sobre [text] en [something]" as consulting it about (with nouns reversed).
Understand "lee [text] en [something]" as consulting it about (with nouns reversed).

Understand "si" or "sí" as saying yes. [TODO: arreglar unicode]
Understand "nx" as saying no.

Understand "sorry" as saying sorry. Understand the commands "perdon","perdona","siento","lamento" and "disculpa" as "sorry". [TODO no permite argumento 'topic']
Understand "lo siento/lamento" as saying sorry.
Understand "lo siento/lamento mucho" as saying sorry.

[Understand "shit" as swearing obscenely.] 
Understand "shit [text]" or "shit" as insultando.
Understand the commands "mierda", "jode","joder","puta","cono","cabron","puto","damn" and "fuck" as "shit".
Insultando is an action applying to one topic. 
The specification of the insultando action is "En inglés existe la acción 'swearing obscenely' pero no permite
al jugador agregar texto después de una palabrota. Por ello, este 'insultando' sí lo permite (como lo hacía InformATE).".
Check insultando:
    say "Los verdaderos aventureros no usan ese vocabulario.".


[Understand "aburrido" as swearing mildly. ]
Understand "aburrido [text]" and "aburrido" as insultandosuave.
Understand the commands "idiota","tonto" and "bobo" as "aburrido".
InsultandoSuave is an action applying to one topic. 
The specification of the insultandosuave action is "En inglés existe la acción 'swearing mildly' pero no permite
al jugador agregar texto después de un insulto suave. Por ello, este 'insultando suave' sí lo permite (como lo hacía InformATE).".
Check insultandosuave:
    say "Bastante.".

Understand "busca en [something]" as searching.
Understand "busca [text] en [something]" as consulting it about (with nouns reversed).
Understand "busca en [something] sobre [text]" as consulting it about.
Understand "busca en [something] [text]" as consulting it about.
Understand "busca en [something] acerca de [text]" as consulting it about.

Understand "registra a [someone]" as searching. Understand the command "rebusca" as "registra".
Understand "registra [something]" as searching.
Understand "registra en [something]" as searching.

Understand "ondea [someone]" as attacking. Understand the command "sacude" and "agita" as "ondea".
Understand "ondea a [someone]" as attacking.
Understand "ondea la mano" as waving hands.
Understand "ondea las manos" as waving hands.
Understand "ondea [something]" as waving.
Understand "gesticula" as waving hands.
Understand "saluda con la mano" as waving hands.
Understand "saluda" as waving hands. [new]

Understand "ajusta [something] en/a [text]" as setting it to. Understand the command "fija" and "set" as "ajusta".

Understand "pulsa [something]" as pushing.

Understand "empuja [something]" as pushing. Understand the command "mueve","desplaza" and "menea" as "empuja".
Understand "empuja a [someone]" as pushing.
Understand "empuja [something] hacia [direction]" or "empuja [something] [direction]" as pushing it to.

Understand "gira [something]" as turning. Understand the command  "atornilla" and "desatornilla" as "gira".

Understand "conecta [something]" as switching on.
Understand "conecta [something] a/con [something]" as tying it to.

Understand "enciende [a device]" as switching on. Understand the command "prende" as "enciende".
Understand "enciende [something]" as burning.

Understand "desconecta [something]" as switching off. Understand the command "apaga" as "desconecta".
Understand "desconecta a [someone]" as switching off.

Understand "rompe [something]" as attacking.
Understand "rompe a [someone]" as attacking.
Understand the commands "aplasta","golpea","destruye","patea" and "pisotea" as "rompe".

Understand "ataca a [someone]" as attacking.
Understand "ataca [something]" as attacking.
Understand the commands  "mata","asesina","tortura" and "noquea" as "ataca".
Understand "lucha con [someone]" as attacking.
Understand "lucha [someone]" as attacking.

Understand "espera" or "z" as waiting.

Understand "responde a [someone] [text]" as answering it that.
Understand "responde [text] a [someone]" as answering it that (with nouns reversed). [TODO ¿como es el orden correcto?]
Understand "responde [someone] [text]" as answering it that.
Understand the commands "di","grita" and "dile" as "responde".

Understand "cuenta [someone] de/sobre [text]" as telling it about.
Understand "cuenta [someone] [text]" as telling it about.
Understand "cuenta a [someone] de/sobre [text]" as telling it about.
Understand "cuenta a [someone] [text]" as telling it about.
Understand "cuenta con [someone] sobre/de [text]" as telling it about.
Understand "cuenta con [someone] acerca de [text]" as telling it about.
Understand "cuenta sobre [text] con [someone]" as telling it about (with nouns reversed).
Understand "cuenta acerca de [text] con [someone]" as telling it about (with nouns reversed).
Understand "cuenta de [text] con/a [someone]" as telling it about (with nouns reversed).
Understand "cuenta [text] a [someone]" as telling it about (with nouns reversed).
Understand the commands "narra","explica" and "habla" as "cuenta".
	
Understand "pregunta [someone] sobre/por [text]" as asking it about. Understand the command "interroga" as "pregunta".
Understand "pregunta a [someone] sobre/por [text]" as asking it about.
Understand "pregunta sobre/por [text] a [someone]" as asking it about (with nouns reversed).
Understand "pregunta [text] a [someone]" as asking it about (with nouns reversed).
Understand "pregunta a [someone] acerca de [text]" as asking it about.

Understand "pide a [someone] [something]" as asking it for. Understand the command "pidele" as "pide".
Understand "pide [something] a [someone]" as asking it for (with nouns reversed).

Understand "come [something preferably held]" as eating.
Understand the commands  "comete","traga","ingiere","mastica","comerse" and "comerte" as "come".	

Understand "duerme" or "ronca" or "descansa" as sleeping.

[Understand "canta" as singing.]

Understand "escala a [something]" as climbing. Understand the command "trepa" as "escala".
Understand "escala [something]" as climbing.
Understand "escala por [something]" as climbing.

Understand "baja [something]" as getting off.
Understand "baja de [something]" as getting off.

Understand "baja" as bajando.

Bajando is an action applying to nothing.
The specification of the bajando action is "Esta acción se ejecuta con el comando
'baja', asumiendo que en realidad se quiere bajar a alguna localidad que se tenga debajo, y que en
el juego esté correctamente mapeada de manera que corresponda al 'down' de la localidad actual.".
Carry out bajando: try going down.

Understand "subete a/en [something]" as entering. Understand the command "subirse" and "subirte" as "subete".

Subiendo is an action applying to nothing.
The specification of the subiendo action is "Esta acción se ejecuta con el comando
'sube', asumiendo que en realidad se quiere subir a alguna localidad que se tenga arriba, y que en
el juego esté correctamente mapeada de manera que corresponda al 'up' de la localidad actual.".
Carry out subiendo: try going up.

Understand "sube" as subiendo.
Understand "sube arriba" as subiendo.

Understand "sube [something]" as entering.
Understand "sube a/en/por [something]" as entering.
Understand "baja a/en/por [something]" as entering.

Understand "compra [something]" or "adquiere [something]" as buying.

Understand "retuerce [something]" as squeezing.
Understand "retuerce a [someone]" as squeezing.
Understand the commands "aprieta","estruja" and "tuerce" as "retuerce".

[Understand "nada" as swimming.] [Actions withdrawn]

Understand "balanceate en [something]" as swinging.
Understand the commands "columpiate","meneate","balancearse","columpiarse","menearse","balancearte","columpiarte" and "menearte" as "balanceate".

[Understand "sopla [something]" as blowing.] [Actions withdrawn]

[Understand "rezar" as praying.][ action withdrawn]

Understand "despierta" as waking up.
Understand "despierta [someone]" or "despierta a [someone]" as waking. Understand the command "espabila" as "despierta".

Understand "espabilate" or "espabilarse" or "espabilarte" as waking up.

Understand "besa [someone]" as kissing. Understand the command "abraza" as "besa".
Understand "besa a [someone]" as kissing.

Understand "piensa" as thinking.

Understand "huele" as smelling. Understand the command "olfatea" as "huele".
Understand "huele a [something]" as smelling.
Understand "huele [something]" as smelling.

Understand "escucha" as listening. Understand the command "oye" as "escucha".
Understand "escucha a [something]" as listening.
Understand "escucha [something]" as listening.

Understand "saborea [something]" as tasting. Understand the commands  "paladea","prueba" and "lame" as "saborea".
Understand "saborea a [something]" as tasting.

Understand "toca [something]" as touching. Understand the command "palpa" as "toca".
Understand "toca a [someone]" as touching.

Understand "lava [something]" as rubbing. Understand the commands "limpia","pule","abrillanta","friega" and "frota" as "lava".
Understand "lava a [someone]" as rubbing.

Understand "ata [something]" as tying it to. Understand the commands  "enlaza","enchufa" and "une" as "ata".
Understand "ata a [someone]" as tying it to.
Understand "ata a [someone] a [something]" as tying it to.
Understand "ata [something] a [something]" as tying it to.

Understand "quema [something]" as burning.
Understand "quema a [someone]" as burning.
[Understand "quema a [someone] con [something preferably held]" as burning.]
[Understand "quema [something] con [something preferably held]" as burning.] [TODO La accion Burn no contempla second noun]

Understand "bebe [something]" as drinking.

[Understand "llena [something]" as filling. Understand the command "rellena" as "llena".] [Actions withdrawn]

Understand "corta [something]" as cutting. Understand the command "rasga" as "corta".
[Understand "corta [something] con [something preferably held]" as cutting.] [TODO no contempla second noun]

Understand "salta" as jumping.
[Understand "salta [something]" as jumping over.] [Actions withdrawn]
Understand "salta a [something]" as entering.Understand the command "brinca" as "salta".
[Understand "salta sobre [something]" as jumping over.]
[Understand "salta por encima de [something]" as jumping over.]

[Understand "cava en [something]" as digging. Understand the command "excava" as "cava".] [Actions withdrawn]
[Understand "cava [something]" as digging.
Understand "cava [something] con [something preferably held]" as digging.
Understand "cava en [something] con [something preferably held]" as digging.]



Part 4.2.2.2 - Grammar for Actions which happen out of world

Understand "score" or "puntos" or "puntuacion" as requesting the score.
Understand "quit" or "q" or "terminar" or "fin" or "acabar" or "abandonar" as quitting the game.
Understand "save" or "guardar" or "salvar" as saving the game.
Understand "restart" or "reiniciar" as restarting the game.
Understand "restore" or "recuperar" or "cargar" or "load" or "restaurar" as restoring the game.
Understand "verify" or "verificar" as verifying the story file.
Understand "version" as requesting the story file version.
Understand "script" or "script on/si" as switching the story transcript on. Understand the command "transcripcion" as "script".
Understand "script off/no" as switching the story transcript off.
Understand  "noscript" or "unscript" or "notranscripcion" as switching the story transcript off.
Understand "superbreve" or "corto" as preferring abbreviated room descriptions.
Understand "verbose" or "largo" as preferring unabbreviated room descriptions.
Understand "breve" or "normal" as preferring sometimes abbreviated room descriptions.
Understand "pronombres" or "p" as requesting the pronoun meanings.
Understand "notify" or "notify on/si" as switching score notification on. Understand the commands "notificar" and "notificacion" as "notify".
Understand "notify off/no" as switching score notification off.


Part 4.2 - Additional language-specific actions

[Section SL3/11 - Declaraciones VerboIrregular]
[Hay problemas con los Unicode y los acentos. Tener cuidado al editar esto con editores no UTF-8]

Include (-
! Objetos VerboIrregular, necesarios para el parseo de verbos irregulares en espanol (Added by SL)
VerboIrregular "abandonar el juego" with imperativo 'q//' 'quit' 'terminar' 'fin' 'acabar' 'abandonar';
VerboIrregular "abrir" with imperativo 'abre';
VerboIrregular "activar la transcripcin a disco" with imperativo 'script' 'transcripcion';
VerboIrregular "adquirir" with imperativo 'adquiere';
VerboIrregular "ajustar" with imperativo 'set';
VerboIrregular "apretar" with imperativo 'aprieta';
VerboIrregular "atravesar" with imperativo 'atraviesa';
VerboIrregular "bajar" with imperativo 'bajate' 'bajarse' 'irte';
VerboIrregular "balancear" with imperativo 'balanceate' 'meneate' 'balancearse' 'menearse' 'balancearse' 'menearse';
VerboIrregular "cambiar a modo LARGO" with imperativo 'verbose' 'largo';
VerboIrregular "cambiar a modo NORMAL" with imperativo 'breve' 'normal';
VerboIrregular "cambiar a modo SUPERBREVE" with imperativo 'superbreve' 'corto';
VerboIrregular "cambiar el dialecto del juego" with imperativo 'dialecto';
VerboIrregular "cambiar el estado de la NOTIFICACION de PUNTOS" with imperativo 'notificar' 'notify';
VerboIrregular "cargar un juego previamente guardado en disco" with imperativo 'cargar' 'recuperar' 'load' 'restaurar' 'restore';
VerboIrregular "cerrar" with imperativo 'cierra';
VerboIrregular "columpiar" with imperativo 'columpiate' 'columpiarse' 'columpiarse';
VerboIrregular "comer" with imperativo 'comete' 'comerse' 'comerte';
VerboIrregular "ingerir" with imperativo 'ingiere';
VerboIrregular "conocer el número de VERSION del juego" with imperativo 'version';
VerboIrregular "conocer la puntuación" with imperativo 'score' 'puntos' 'puntuacion';
VerboIrregular "conocer la puntuación detallada" with imperativo 'total' 'pt';
VerboIrregular "contar" with imperativo 'cuenta';
VerboIrregular "cubrir" with imperativo 'cubre';
VerboIrregular "darle" with imperativo 'dale' 'dase' 'darse';
VerboIrregular "decir" with imperativo 'di' 'dile';
VerboIrregular "desactivar la transcripción a disco" with imperativo 'unscript' 'noscript' 'notranscripcion';
VerboIrregular "descubrir" with imperativo 'descubre';
VerboIrregular "despertar" with imperativo 'despierta' 'espabilate' 'espabilarse' 'espabilarte';
VerboIrregular "destruir" with imperativo 'destruye';
VerboIrregular "disculparte" with imperativo 'sorry' 'perdon';
VerboIrregular "dormir" with imperativo 'duerme' 'dormir';
VerboIrregular "echar" with imperativo 'echate' 'echarse';
VerboIrregular "encender" with imperativo 'enciende';
VerboIrregular "esperar" with imperativo 'z//';
VerboIrregular "examinar" with imperativo 'x//' 'describe' 'ex';
VerboIrregular "fregar" with imperativo 'friega';
VerboIrregular "guardar en disco el estado del juego" with imperativo 'save' 'guardar' 'salvar';
VerboIrregular "ir" with imperativo 've' 'vete' 'ir';
VerboIrregular "volver" with imperativo 'vuelve';
VerboIrregular "levantar" with imperativo 'levantate' 'levantarse' 'levantarte';
VerboIrregular "listar los lugares visitados" with imperativo 'places' 'lugares';
VerboIrregular "listar los objetos que se han tenido" with imperativo 'objects' 'objetos';
VerboIrregular "meter" with imperativo 'metete' 'meterse' 'meterte' 'meterme' 'meteme';
VerboIrregular "mirar" with imperativo 'l//' 'look' 'm//';
VerboIrregular "mostrar" with imperativo 'muestra';
VerboIrregular "mostrar inventario" with imperativo 'i//' 'inv' 'inventario';
VerboIrregular "mover" with imperativo 'mueve';
VerboIrregular "oir" with imperativo 'oye';
VerboIrregular "oler" with imperativo 'huele';
VerboIrregular "pedir" with imperativo 'pide' 'pidele';
VerboIrregular "pensar" with imperativo 'piensa';
VerboIrregular "poner" with imperativo 'pon' 'ponte' 'viste' 'vistete' 'ponerse' 'vestirse' 'ponerte' 'vestirte' 'ponerme' 'vestirme' 'ponme' 'visteme';
VerboIrregular "probar" with imperativo 'prueba';
VerboIrregular "pulir" with imperativo 'pule';
VerboIrregular "quitar" with imperativo 'sacate' 'quitate' 'sacarse' 'quitarse' 'quitarte' 'sacarte' 'sacarme' 'quitarme' 'quitame' 'sacame';
VerboIrregular "quitarle" with imperativo 'quitale';
VerboIrregular "reiniciar el juego" with imperativo 'reiniciar';
VerboIrregular "responder ~no~" with imperativo 'nx';
VerboIrregular "responder ~sí~" with imperativo 'si' 'y//';
VerboIrregular "sacudir" with imperativo 'sacude';
VerboIrregular "salir" with imperativo 'sal' 'fuera' 'afuera' 'salte' 'salirse' 'salirte';
VerboIrregular "sentar" with imperativo 'sienta' 'sientate' 'sentarse' 'echarte' 'sentarte';
VerboIrregular "soltar" with imperativo 'suelta';
VerboIrregular "subir" with imperativo 'sube' 'subete' 'subirse' 'subirte';
VerboIrregular "torcer" with imperativo 'tuerce';
VerboIrregular "retorcer" with imperativo 'retuerce';
VerboIrregular "transferir" with imperativo 'transfiere';
VerboIrregular "unir" with imperativo 'une';
VerboIrregular "ver el estado de los pronombres" with imperativo 'pronombres';
VerboIrregular "verificar la corrección del juego" with imperativo 'verificar';
VerboIrregular "mostrar las salidas" with imperativo 'salidas'; ! Urba touch
#ifdef DEBUG;
VerboIrregular "purloin" with imperativo 'purloin';
VerboIrregular "hacer con abstract" with imperativo 'abstract' 'xmueve';
VerboIrregular "hacer con gonear (indica lugar)" with imperativo 'gonear' 'xmueve';
#endif;
-).

Part SL4 - Spanish Phrasebook

Section SL4/0 - Spanish Saying, basados en la rutinas de impresión de InformATE!
[ Documentacion de esta seccion: DocumentATE: Descripciones y Parsing: Descripcion de objetos y lugares ]

[Articulos ]
[To say el (something - object):	(- print (the) {something}; -).
To say El (something - object):	(- print (The) {something}; -).
To say un (something - object):	(- print (un) {something}; -).
To say Un (something - object):	(- print (_Un) {something}; -).] [se usan similares en Chapter 2.1.1 - Articles]

To say del (something - object): (- print (del) {something}; -).
To say al (something - object):	(- print (al) {something}; -).
To say Al (something - object):	(- print (_Al) {something}; -).

To say el_ (something - object):	(- print (el_) {something}; -). [imprime "el" o "la"]
To say del_ (something - object):	(- print (del_) {something}; -). [imprime "del" o "de la"]

[ Terminaciones para adjetivos ]
To say o (something - object): (- print (o) {something}; -).[say "Cogid[o noun]".]
To say s (something - object): (- print (s) {something}; -). [say "Ya no está[n noun] tan negro[s noun].".]
To say _s (something - object): (- print (_s) {something}; -).


[ Terminaciones para verbos ]
To say es (something - object): (- print (es) {something}; -).
To say Es (something - object): (- print (_Es) {something}; -).
To say n (something - object): (- print (n) {something}; -). [say "Ya no está[n noun] allí.".]
To say lo (something - object): (- print (lo) {something}; -). [say "Cóge[lo noun]".]
	

[ Verbo COGER/TOMAR segun dialecto ]
To say coge: (- coge(0); -).
To say Coge: (- Mcoge(0); -).
To say MMcoge: (- MMcoge(0); -).

[Misc]
To say (something - time) in spanish:			[decir la hora en español]
	(- print (PrintTimeOfDayEnglish) {something}; -).

[To say (something - time) con palabras:	            	[decir la hora en español] [vamos a dejar esto por un tiempo]
	(- print (PrintTimeOfDaySpanish) {something}; -).]

To say esta (something - object): (- print (esta) {something}; -).[ "está" / "están" ]

Part 4.3 - Command parser internals

Section 1 - Asuntos preliminares

Include (-

! =====================================================================
! INFSP (Spanish Inform Library)
! =====================================================================
!        Author: INFSP Task Team
!       Version: 0.97
!      Revision: 08 - Mayo - 2014
! Serial Number: 14005.08

Message "^Compilando con Spanish: Mensajes y rutinas de idioma [INFSP 0.97 MAYO 2014]";
Message "   Asegurate de estar corriendo I7 Build 6L02^";

! ---------------------------------------------------------------------------
!   Parte I.   Asuntos preliminares
! ---------------------------------------------------------------------------

Constant LanguageVersion = "  - Librería I6 Española 1010.29, basada en InformATE!";

! Definición de caractéres "baratos". Esto permite que estas letras
! ocupen menos bits en la máquina Z. No funciona si se intenta la
! compilación por módulos (viejo método)

#ifdef TARGET_ZCODE;
  Zcharacter 'á';                    ! a con acento
  Zcharacter 'é';                    ! e con acento
  Zcharacter 'í';                    ! i con acento
  Zcharacter 'ó';                    ! o con acento
  Zcharacter 'ú';                    ! u con acento
  Zcharacter 'ñ';                    ! n con virguilla
  Zcharacter 'Ñ';                    ! N con virguilla
  Zcharacter 'ü';                    ! u con dieresis
  Zcharacter '¿';                    ! abrir interrogación
  Zcharacter '¡';                    ! abrir exclamación
#endif;

!----------------------------------------------
! CONSTANTES Y CLASES ESPECIFICAS DE INFORMATE
!---------------------------------------------- 

Class VerboIrregular;

!------------------------------------
! Globales específicas de InformatE!
!------------------------------------

global PreguntaCualExactamente = 0;
	! Esta variable se pone a 1 cuando se le pregunta al jugador ¿Cuál
	! exactamente...? esto indica que puede ser necesario re-traducir la
	! respuesta que el jugador dé, ya que puede que simplemente el jugador
	! cambie de idea y en lugar de responder a nuestra pregunta introduzca
	! un comando completamente nuevo.

global PreguntaSiNo = 0;
	! Esta variable debe ponerse a 1 manualmente si queremos que el verbo
	! 'no' sea accesible como respuesta (y no como punto cardinal). La
	! variable sólo afecta a la siguiente respuesta del jugador y vuelve a
	! hacerse cero automáticamente.

Global quitacentos = 1;

Array  texto_impreso --> 52;

#ifndef NI_BUILD_COUNT;
Global dialecto_sudamericano = 0;
#ifnot;
    #ifndef DIALECTO_SPANISH; ! seteado desde el I7 environment
       Global dialecto_sudamericano = 0;
    #endif;
#endif;

!---------------------------------------------------------------------------
! Atributos y propiedades específicas de InformatE!, tambien usados en INFSP
!---------------------------------------------------------------------------

Property imperativo alias name;
Property irrelevante alias name;

-) after "Definitions.i6t". 


Include (-
! Definicion de bufferaux y parseraux, usados en DictionaryLookup [001115]
#ifdef TARGET_ZCODE;
  Array bufferaux -> 123;
  Array parseaux  buffer 63;
#ifnot; ! TARGET_GLULX
  Array  bufferaux    buffer INPUT_BUFFER_LEN;
  Array parseaux  --> PARSE_BUFFER_LEN;
#endif; ! TARGET_



! Tremendo bug corregido. Antes usaba el buffer buf2, el cual usa
! tambien el parser para leer commandos incompletos del estilo de "¿a
! cual te refieres exactamente?"
! Este bug estaba en la libreria original, pero nunca aparecia porque
! apenas se usa DictionaryLookup. En cambio InformATE lo usa para
! comprobar si quitando la R a un verbo se obtiene una palabra válida.
!
! [Gracias a Presi por detectarlo] 
[ DictionaryLookup texto longitud
    i;

	! copiar texto a bufferaux (copiado especial)
	for (i=0:i<longitud:i++) bufferaux->(WORDSIZE+i) = texto->i;
	! completar correctamente cabeceras de los buffers
	!	para la rutina Tokenise.
#ifdef TARGET_ZCODE;
	bufferaux->1 = longitud;
	bufferaux->0 = 120;
	parseaux-> 0 = 1;
#ifnot; ! TARGET_GLULX
	bufferaux-->0 = longitud;
#endif; ! TARGET_
#ifdef DEBUG;
    if (parser_trace>=9) { ! infsp debug
		print "    DictionaryLookup: texto a procesar: |";
        ImprimeTodoElBuffer(bufferaux);
        print "|^";
    }
#endif;
	VM_Tokenise(bufferaux,parseaux); ! procesar texto de bufferaux, el resultado está en parseaux-->1
	return parseaux-->1; ! retornar address del token encontrado (-1 si falla)
];

-) before "Vocabulary" in "Language.i6t".

Section 3 - Vocabulary

Include (-
Constant AGAIN1__WD = 'repetir';
Constant AGAIN2__WD = 're';
Constant AGAIN3__WD = 'g//';
Constant OOPS1__WD    = 'oops';
Constant OOPS2__WD    = 'epa';
Constant OOPS3__WD    = 'eepa';
Constant UNDO1__WD  = 'undo';
Constant UNDO2__WD  = 'deshacer';
Constant UNDO3__WD  = 'anular';

Constant ALL1__WD    = 'todos';
Constant ALL2__WD    = 'todas';
Constant ALL3__WD    = 'todo';
Constant ALL4__WD    = 'ambos';
Constant ALL5__WD    = 'ambas';
Constant AND1__WD    = 'y//';
Constant AND2__WD    = 'y//';
Constant AND3__WD    = 'e//';
Constant BUT1__WD   = 'excepto';
Constant BUT2__WD   = 'menos';
Constant BUT3__WD   = 'salvo';
Constant ME1__WD      = '-me';
Constant ME2__WD      = '-te';
Constant ME3__WD      = '-se';
Constant OF1__WD      = '.de';       ! no usados nunca, pues provocan
Constant OF2__WD      = '.de';       ! interferencia con la preposición "de"
Constant OF3__WD      = '.de';       ! usada por algunos verbos, como en
Constant OF4__WD      = '.de';       ! "saca objeto de la caja"
Constant OTHER1__WD    = 'otro';
Constant OTHER2__WD    = 'otra';
Constant OTHER3__WD    = 'otro';
Constant THEN1__WD = 'ydespues';
Constant DESPUES11_WD = 'despues';
Constant THEN2__WD = 'yluego';
Constant DESPUES21_WD = 'luego';
Constant THEN3__WD = 'yentonces';
Constant DESPUES31_WD = 'entonces';

Constant NO1__WD      = 'n//';
Constant NO2__WD      = 'no';
Constant NO3__WD      = 'no';
Constant YES1__WD      = 's//';
Constant YES2__WD      = 'si';
Constant YES3__WD      = 'sí';

Constant AMUSING__WD = 'curiosidades';
Constant FULLSCORE1__WD  = 'puntuacion';
Constant FULLSCORE2__WD  = 'punt';
Constant QUIT1__WD    = 'q//';
Constant QUIT2__WD    = 'terminar';
Constant RESTART__WD    = 'reiniciar';
Constant RESTORE__WD    = 'recuperar';
-) instead of "Vocabulary" in "Language.i6t".


Part 4.4 - Informese translation of commands

Section 6 - Translation

Include (-
! ---------------------------------------------------------------------------
!   Parte III.   Traducción
! ---------------------------------------------------------------------------

!------------------------------------
! Funciones de ayuda a la depuración
!------------------------------------

#ifdef DEBUG;
[ ImprimeBuffer b desde l i;
    for (i=desde:i<desde+l:i++)
    print (char) b->i;
];

[ ImprimeTodoElBuffer b;
#ifdef TARGET_ZCODE;
   ImprimeBuffer(b, 2, b->1);
#ifnot; !TARGET_GLULX
   ImprimeBuffer(b, WORDSIZE, b-->0);
#endif;
];

#endif; !DEBUG

#ifdef TARGET_GLULX; ! TARGET_GLULX
[ PasarAMinuscula buffer   ! [INFSP] Necesario en EspanolAInformes (en modo Glulx), para q el buffer
        i;                 !         sea reconocido (al usar infinitivo en mayuscula (EXAMINAR) o verbos pronominales (EXAMINALA)
    for (i=WORDSIZE:i<(WORDSIZE+(buffer-->0)):i++)
        buffer->i = VM_UpperToLowerCase (buffer->i);
    return buffer;
];
#endif; !TARGET_

!----------------------------------------------------------------
! [010515] Rutina nueva, que recibe una palabra de diccionario y un
! lugar donde buscar, y retorna "true" si alguno de los objetos de ese
! lugar tiene esa palabra en su campo nombre, name_f...
!
! Es usada por la rutina ArreglarLosY, pues se mira si la palabra que
! viene detrás de la Y es un nombre, y si lo es, si es aplicable a algún
! objeto cercano. Observar que fallará en los objetos que proporcionen
! su propio parse_name. 
!----------------------------------------------------------------
[ EncajeSimplon w donde i;
  objectloop(i in donde) {
    if (WordInProperty(w, i, name)) rtrue;

    if (children(i) && EncajeSimplon(w, i)) rtrue;
  }
  rfalse;
];


!----------------------------------------------------------------
! QuitarAcentos
!
! La siguiente función prueba a quitar los acentos de las palabras que
! no hayan podido ser interpretadas. De este modo, el jugador puede usar
! o no los acentos. Para ello el juego debe definir las palabras sin acentos
! por ejemplo:
! object sillon "sillón confortable"
! with name 'sillon' 'confortable'
!
! Si el jugador pone: "mira sillon", la palabra encaja directamente y es
! comprendida. Si pone "mira sillón", no es comprendida, de modo que se
! le quita el acento y se reintenta el parsing.
!
! Este caso no es especialmente importante, pues el programador
! siempre puede definir 'sillon' y 'sillón', ambos como nombres para
! el objeto. Pero el asunto es más importante para el caso de los
! verbos, ya que si el jugador teclea "cógelo" este es separado en
! "cóge" y "-lo" y el verbo "cóge" (con acento) no sería
! comprendido.
!
! La llamada a esta función puede desactivarse con el comando de
! debugging "acentos sí" de modo que los acentos que teclee el jugador
! no serán eliminados (con propósitos de depuración)

[ QuitarAcentos buf pars x i word at len;

#ifdef DEBUG;
    if (parser_trace >= 7) ! imprimir el buffer recibido
    {
          print "^[ QuitarAcentos:  ";
          print "Buffer recibido: |";
             ImprimeTodoElBuffer(buf);
          print "|^";
    } 
#endif;
    VM_Tokenise(buf, pars); 
    for (x=1:x<=tokenCount(pars):x++) ! para cada token
    {
	word = tokenDict (pars,x); !dictionary value of token 1,2,3...
	at = tokenPos (pars,x); ! position in buffer of token 1,2,3... 
	len = WordLength (x);! length in chars of token 1,2,3...

	if (word==0) ! no comprendida
       {
#ifdef DEBUG;
		if (parser_trace>=7)
		{
		    print "    QuitarAcentos:NO COMPRENDIDO: |";
			ImprimeBuffer(buf, at, len);
		    print "|^";
		}
#endif;
		for (i=at:i<at+len:i++)
		   switch(buf->i)
		  {
			'á': buf->i='a';
			'é': buf->i='e';
			'ë': buf->i='e';
			'í': buf->i='i';
			'ó': buf->i='o';
			'ú': buf->i='u';
			'ü': buf->i='u';
			'ñ': buf->i='n'; 
		!             '?': buf->i=' ';
		!             '¿': buf->i=' ';
		!             '!': buf->i=' ';
		!         '¡': buf->i=' ' ;    
		   }
        VM_Tokenise(buf, pars); 
        }
    }

#ifdef DEBUG;
    if (parser_trace>=7){
        print "    Buffer sin acentos: |";
        ImprimeTodoElBuffer(buf);
        print "|^";
    }
#endif;
];

! funciones de soporte para gestionar parse y buffer
!  From InformFAQ - Roger Firth

[ tokenDict pars w; ! dictionary value of token 1,2,3...
#Ifdef TARGET_ZCODE;
	return pars-->(2*w - 1);
#Ifnot; ! TARGET_GLULX
	return pars-->(3*w - 2);
#Endif; ! TARGET_
];
[ tokenLen pars w; ! length in chars of token 1,2,3...
#Ifdef TARGET_ZCODE;
	return pars->(4*w);
#Ifnot; ! TARGET_GLULX
	return pars-->(3*w - 1);
#Endif; ! TARGET_
];
[ tokenPos pars w; ! position in buffer of token 1,2,3...
#Ifdef TARGET_ZCODE;
	return pars->(4*w + 1);
#Ifnot; ! TARGET_GLULX
	return pars-->(3*w);
#Endif; ! TARGET_
]; 

[ tokenCount pars;
#Ifdef TARGET_ZCODE;
	return pars->1;
#Ifnot; ! TARGET_GLULX
	return pars-->0;
#Endif; ! TARGET_
];

!-----------------------------------------------------
! LanguageToInformese
!
! Esta parte es interesante. Debe separar los sufijos pronominales
! como en "cogela" "mirale", claro que no basta con ver si las dos
! últimas letras del verbo son "la" "le", etc, pues el verbo podría
! terminar de forma "natural" en esas letras (como en "habla"). Así
! que hay que separar el sufijo sólo si el verbo no ha sido hallado en
! el diccionario.
!
[ LanguageToInformese ;
    EspanolAInformes(buffer, parse);
];

! La función que verdaderamente hace la traducción es la siguiente. Ha
! sido separada de LanguageToInformese porque es llamada también desde
! LanguageIsVerb, pero recibe un buffer diferente para procesar. 

[ EspanolAInformes buf pars x i word at len romper_en siguiente retokenise at2; !    print "   EspanolAInformes called^"; ! infsp debug

   #ifdef TARGET_GLULX; ! TARGET_GLULX
    buf = PasarAMinuscula (buf); ![INFSP] Necesario para q no cazque al procesar infinitivos
   #endif;

    VM_Tokenise( buf, pars);     retokenise=0;
#ifdef DEBUG;
    if (parser_trace>=7) !imprimir el buf recibido
    {
          print "^[ EspanolAInformes:  ";
          print "Buffer recibido: |";
		ImprimeTodoElBuffer(buf);
          print "|^  ";
    } 
#endif;
    if (quitacentos) QuitarAcentos(buf, pars);

     for (x=1:x<=tokenCount(pars):x++) ! para cada token
    {
	word = tokenDict (pars,x); !dictionary value of token 1,2,3...
	at = tokenPos (pars,x); ! position in buffer of token 1,2,3... 
	len = tokenLen (pars,x);! length in chars of token 1,2,3...

#ifdef DEBUG;
	if (parser_trace>=7){
          print "Palabra ",x," : ";
          if (word==0)
            print "<no comprendida>";
          else 
            print (address) word," ^";
          print " ^";
        }        
#endif;

	if (dialecto_sudamericano && (word == 'coge'))
	{
	  ! Un poco bestia, pero funciona. En caso de dialecto sudamericano,
	  ! cambiar un par de letras convierte "coge" en "jode"
	  buf->(at)     = 'j';
	  buf->(at + 2) = 'd';
	  retokenise    = 1;
	  if (dialecto_sudamericano == 1)  ! [071030_git]
	  {
	    print "[Este juego utiliza por defecto el dialecto sudamericano,
		    por lo que aquí COGER es entendido como una palabra
		    malsonante. Por favor, utiliza TOMAR en su lugar, o bien
		    elige el dialecto castellano con DIALECTO CASTELLANO.]^";
	    dialecto_sudamericano = 2;
	  }
	}
    
    if (word=='del' or 'al')
    {
        buf->(at+len-1)=' ';    ! convertir "del" "al" en "de"
                                       ! "a" respectivamente
        retokenise=1;
    }
    

    ! Si el jugador ha escrito "no", y previamente el programador
    ! había puesto a 1 el flag "PreguntaSiNo" (que indica que
    ! acaba de hacerse una pregunta que podría admitir NO como
    ! respuesta), en ese caso cambiamos "no" por "xo". La
    ! gramática define el verbo "xo" para generar la acción NO
    ! (negar), y así lo distinguimos de la acción "Ir noroeste"
    if ((word=='no')&&(PreguntaSiNo==1))
    {
        buf->(at+len-1)='x';
        PreguntaSiNo=0;
        retokenise=1;
    }
        
        ! "pegar" las expresiones "y luego" "y despues" "y entonces"
        ! para que queden "yluego" "ydespues" "yentonces"
        ! que es como las reconoce el parser
     if (word=='y//')
    {
       siguiente= tokenDict (pars,x+1); ! palabra siguiente

	if (siguiente==DESPUES11_WD or DESPUES21_WD or DESPUES31_WD)
       {
	   at2 = tokenPos (pars,x+1); ! position in buffer of token 1,2,3... 
           for (i=0:i<tokenLen(pars,x+1):i++){
                   buf->(at2+i) = ' '; ! borrar palabra 'entonces' (pisándola con espacios)
	   }
           buf->(at+len)='l'; ! agregar 'luego' inmediatamente despues de 'y', formando 'yluego'
           buf->(at+len+1)='u';
           buf->(at+len+2)='e';
           buf->(at+len+3)='g';
           buf->(at+len+4)='o';
           retokenise=1;
#ifdef DEBUG;
           if (parser_trace>=7) !imprimir el buf recibido
	   {
		print "^[   YLUEGO:  ";
		print "Buffer recibido: |";
		ImprimeTodoElBuffer(buf);
		print "|^  ";
	    } 
#endif;
       }
    }     

    if (word==0) ! no comprendida
    {
#ifdef DEBUG;
        if (parser_trace>=7)
        {
            print "NO COMPRENDIDO: |";
            ImprimeBuffer(buf, at, len);
            print "|^";
        }
#endif;        
        if (len > 2) !sólo si tiene más de tres letras
        {
           romper_en=0;
           if ((buf->(at+len-1)=='s') &&
            (buf->(at+len-2)=='a' or 'o' or 'e') &&
            (buf->(at+len-3)=='l'))
            romper_en=3;
           if ((buf->(at+len-1)=='a' or 'o' or 'e') &&
            (buf->(at+len-2)=='l'))
            romper_en=2;
           if ((buf->(at+len-1)=='e') &&
            (buf->(at+len-2)=='m' or 't' or 's'))
            romper_en=2;  ! [001108] Antes ponía == ¡seré burro!
           if (romper_en) 
           {
            ! [990524]
            ! Antes de modificar el buffer, comprobemos si
            ! servirá para algo, es decir, si la palabra que
            ! queda una vez separado el sufijo existe en el
            ! diccionario y es un verbo
            i=DictionaryLookup(buf+at, len-romper_en);
            
              if (i) if ((i->#dict_par1)&1)
              {
                LTI_Insert(at+len-romper_en, '-', buf);
                LTI_Insert(at+len-romper_en, ' ', buf);
                VM_Tokenise(buf,pars);
               }
              if (QuitandoRFinal(buf+at, len-romper_en)||
                  BuscarEntreVerbosIrregulares(buf+at, len-romper_en))
              {
                LTI_Insert(at+len-romper_en, '-', buf);
                LTI_Insert(at+len-romper_en, ' ', buf);
                VM_Tokenise(buf,pars);
               }
             } ! if (romper_en
        } ! if (len > 2
    } ! if (word==0
    } ! for (x=0:

    if (retokenise==1) ! [INFSP] Agregado if, como en la seccion Glulx
       VM_Tokenise(buf, pars);

    ArreglarLosY(buf, pars);
    
    ! Como paso final, quitamos las palabras que aparezcan dos veces
    ! seguidas. Esto puede ocurrir si el jugador teclea un comando
    ! incompleto, como "MIRA HACIA", y el parser le pregunta "¿Hacia
    ! donde quieres mirar?" y el jugador responde "HACIA EL NORTE". En
    ! este caso se construiría la orden concatenada: "MIRA HACIA HACIA
    ! EL NORTE".
    if (PreguntaCualExactamente==1){
        PreguntaCualExactamente=0;
        EliminarDuplicados(buf, pars);
    }
    
#ifdef DEBUG;
    if (parser_trace>=7){
       print "Buffer traducido a informese: ^|";
        ImprimeTodoElBuffer(buf);
       print "| (", pars->1," palabras) ^";
    }
#endif;
];


[ ArreglarLosY buf pars
    word at len x i retoke;

    for (x=1:x<=tokenCount(pars):x++) ! para cada token
    {
 	word = tokenDict (pars,x); !dictionary value of token 1,2,3...
        if (word=='y//')
	{
		i = tokenDict (pars,x+1); ! palabra siguiente
        ! [010515] arreglado bug. at y len no apuntaban a la
        ! palabra siguiente, sino a la propia 'y', por lo que no
        ! eran reconocidos los verbos en infinitivo
		at = tokenPos (pars,x+1); ! position in buffer of token siguiente 
		len = tokenLen (pars,x+1);! length in chars of token siguiente

        ! [010515] Añadido. Si la palabra es noun, se retorna
        ! (aunque pueda ser también un verbo) de este modo, en
        ! COGE VINO Y CAVA, si el juego tiene un objeto llamado
        ! "cava", la frase será parseada como tratando de coger
        ! dos objetos, llamados "vino" y "cava". Si el juego no
        ! define el sustantivo "cava", la frase será parseada como
        ! dos acciones en secuencia <<Coger vino>> y <<Excavar>>
		if (i && (i->#dict_par1)&128) {
			if (EncajeSimplon(i, location)) continue;
		}
		if (i && ((i->#dict_par1)&1)||QuitandoRFinal(buf+at,len)||
			BuscarEntreVerbosIrregulares(buf+at, len))
		{
			at = tokenPos (pars,x); ! position in buffer of token siguiente 
			buf->(at)='.';
			retoke=true;
		}
	}
    }
    if (retoke) VM_Tokenise(buf, pars);
];

[ EliminarDuplicados buf pars
    word at len x i siguiente retokenise;

!    VM_Tokenise(buf, pars);
#ifdef DEBUG;
    if (parser_trace>=8) !imprimir el buffer recibido
    {
          print "^[ EliminarDuplicados:  ";
          print "Buffer recibido: |";
              ImprimeTodoElBuffer(buf);
          print "| (", pars->1, " palabras)^";
    } 
#endif;
    for (x=1:x<=tokenCount(pars):x++) ! para cada token
    {
	word = tokenDict (pars,x); !dictionary value of token 1,2,3...
	siguiente = tokenDict (pars,x+1); !dictionary value of token 1,2,3...
	at = tokenPos (pars,x); ! position in buffer of token 1,2,3... 
	len = tokenLen (pars,x);! length in chars of token 1,2,3...
    if ((word==siguiente) && (word~=0))
    {
#ifdef DEBUG;
        if (parser_trace>=8) print "Encontrados duplicados!:",
		(address) word, "=", (address) siguiente, ".^";
#endif;
        for (i=at:i<at+len:i++) buf->i=' ';
        retokenise=1;
    }
    }
    if (retokenise) 
    VM_Tokenise(buf, pars);

#ifdef DEBUG;
    if (parser_trace>=8) !imprimir el buffer recibido
    {
          print "Buffer resultante: |";
        ImprimeTodoElBuffer(buf);
          print "| (", pars->1, " palabras)^";
    } 
#endif;
];


! La siguiente función debe devolver si el verbo recibido es
! reconocido o no. Se recibe el buffer completo y "pos" indica qué
! palabra dentro del buffer "pars" es el supuesto verbo.
! Hay que devolver la dirección de diccionario del verbo en cuestión.
!
! Lo usamos para admitir infinitivos. El método es:
!   Si la palabra corresponde a una palabra de diccionario, no hacemos
!   nada (retornamos esa palabra, sin molestarnos en comprobar que sea
!   un verbo. Ya lo hará el parser).
!
!   Si la palabra no está en el diccionario, miramos si termina en
!   'r', y de ser así se la quitamos y re-tokenizamos. Si de este modo
!   se obtiene una palabra en el diccionario, retornamos su valor (sin
!   comprobar que sea un verbo, ya lo hará el parser).
!
!   Si tampoco de este modo se reconoce, comparamos la palabra dada
!   con todos los verbos irregulares conocidos. Si en uno de ellos
!   encontramos coincidencia, retornamos el primer elemento de la
!   propiedad "imperativo" del verbo en cuestión.
!
!   En el caso de la desambiguacion, puede darse que el jugador responda
!   con un verbo nuevo, pero con sufijo pronominal la/le/lo/me/te/se (ej. examinala)
!   Por ello se hace una llamada a EspanolAInformes

[ LanguageIsVerb buf pars pos
    i word at len;
    
#ifdef DEBUG;
    if (parser_trace>=7) !imprimir el buffer recibido
    {
	print "^[ LanguageIsVerb:  ";
	print "Buffer recibido: |";
		ImprimeTodoElBuffer(buf);
	print "|, pos=", pos, "^  ";
    } 
#endif;
    if (PreguntaCualExactamente) ! caso de desambiguación
	EspanolAInformes(buf, pars); ! revisar la existencia de sufijos pronominales la/le/lo/me/te/se
    word = tokenDict (pars,pos); !dictionary value of token 1,2,3...
    at = tokenPos (pars,pos); ! position in buffer of token 1,2,3... 
    len = tokenLen (pars,pos);! length in chars of token 1,2,3...

    ! Si la palabra se reconoce, devolverla sin más
     if (word~=0 && word->#dict_par1 & 1 ~= 0)
    {
#ifdef DEBUG;
	if (parser_trace>=7) print " la palabra ~", (address)
		word, "~ está en el diccionario.^";
#endif;
	return    (word);
    }

   
    ! Si no, probar a ver si se reconoce sin la 'r' final
    i=QuitandoRFinal(buf + at,len);

    ! Si no la ha reconocido, intentamos ver si es un verbo irregular
    if (i~=0)
    {
	if (parser_trace>=7) print "^ Verbo reconocido
		al quitarle la 'r' final.^";
    }
    else 
    {
	if (parser_trace>=7) print "^ Verbo no reconocido sin la
		'r'. ^Probando irregulares...";
 	i=BuscarEntreVerbosIrregulares(buf + at,len);
#ifdef DEBUG;
	if (parser_trace>=7) 
	{
		if (i==0) print "No reconocido como irregular.^";
		else print "      Reconocido como el verbo ", (address) i, "^";
	}
#endif;
    }     
       if (parser_trace>=7) 
        print " ^                   -- end LanguageIsVerb ]^";
    return i;    
];

[ QuitandoRFinal texto longitud
    i;

#ifdef DEBUG;
    if (parser_trace>=9) {
	print "^[ QuitandoRFinal: buffer recibido |";
		ImprimeBuffer(texto, 0, longitud);
	print "|^";
    }
#endif;	
	if (texto->(longitud-1)~='r')
    {
	if (parser_trace>=9) print "No termina en 'r'^";
	return 0;
    }
    
    i=DictionaryLookup(texto, longitud-1);     
    if (dialecto_sudamericano && (i == 'coge'))
    {
      if (dialecto_sudamericano == 1)  ! [071030] git
      {
        print "[Este juego utiliza por defecto el dialecto sudamericano,
                por lo que aquí COGER es entendido como una palabra
                malsonante. Por favor, utiliza TOMAR en su lugar, o bien
                elige el dialecto castellano con DIALECTO CASTELLANO.]^";
        dialecto_sudamericano = 2;
      }
      return 'jode';
    }     
     if ((i->#dict_par1)&1) return i;
    else 
    {
    if (parser_trace>=9) print "Está en el diccionario, pero no es verbo.^";
    return 0;
    }
];


[ BuscarEntreVerbosIrregulares texto longitud
    verbo i k;

    objectloop (verbo ofclass VerboIrregular)
    {
#ifdef DEBUG;
	if (parser_trace>=8) print "^[Bucando irregulares. Probando
		con ~", (name) verbo, "~.-->"; 	
#endif;
		k = VM_PrintToBuffer (texto_impreso,46,verbo);

    
        !Si sus longitudes no coinciden no es necesario seguir comparando
        if (k~=longitud) jump NoCoincide;
    
        !Si sus longitudes coinciden, miramos letra a letra
        for (i=0:i<k:i++)
            if ((texto->i)~=(texto_impreso->(i+WORDSIZE)))
        
	jump NoCoincide; ! si una sola letra no coincide,
	! Si ha pasado los test anteriores, hemos hallado una
	! coincidencia
	#ifdef DEBUG;if (parser_trace>=8) print "¡coincide!^";#endif;
	return (verbo.&imperativo-->0);

	.NoCoincide;
	#ifdef DEBUG;if (parser_trace>=8) print "no coincide^";#endif;
    }
    return 0;
];
-) instead of "Translation" in "Language.i6t".

Section 8 - Commands

Include (-
[ LanguageVerb i aux;

    if (ImprimirIrregular(i)==0){
        !print "^   LanguageVerb: Verbo no es irregular.^"; ! infsp debug
      
      ! Tatar de matchear con la brújula - 807.7 infsp
!      objectloop (aux ofclass CompassDirection){
      objectloop (aux in Compass){
        if (WordInProperty(i, aux, name)) {
          print "ir hacia algún lado";
!          !LanguageDirection (aux.door_dir); ! the direction name as adverb
          rtrue; ! no avanzar más en la rutina
        }    
       }
       
       ! Un ultimo intento, con una rutina stub a proveer por el autor
       if (PrintVerb(i)==0){
         print (address) i; print "r";
        }
    }

    if (i=='mete') rtrue;
    
#ifdef TARGET_ZCODE;
    ! Comprobemos si era un verbo reflexivo (-te)
    texto_impreso-->0 = 50;
    @output_stream 3 texto_impreso;
    print (address) i;
    @output_stream -3;
    aux=2;
!    print "^   LanguageVerb: i : ",(address) i,"^"; ! infsp debug
    if (texto_impreso->(texto_impreso->1+1)=='e')
     if (texto_impreso->(texto_impreso->1) == 't' or 's' or 'm')
     {
!     print "^   LanguageVerb:Verbo reflexivo."; ! infsp debug
       if (actor ~= player) print "se";
        else print (string) PARTICULA_TE; ! "te"
     }
#endif;
#ifdef TARGET_GLULX;
    aux=Glulx_PrintAnyToArray(texto_impreso, 50, i);
    if ((texto_impreso->(aux-1)=='e')&&
        (texto_impreso->(aux-2) == 't' or 's' or 'm')) 
    {
       if (actor ~= player) print "se";
        else print (string) PARTICULA_TE;
    }
#endif;
    rtrue;

];

[ ImprimirIrregular v i;
  ! Imprime los verbos irregulares (es decir, aquellos en los que no basta
  ! añadir una "r" al imperativo). Por ejemplo, si el jugador teclea "friega"
  ! la respuesta por defecto sería "¿Qué quieres friegar?"
  ! Para evitar esto, el programador debe definir un objeto de la clase
  ! VerboIrregular, con nombre "fregar" y propiedad name = "friega"
  ! Esta rutina busca entre los verbos así definidos, en el campo name
  ! y si encuentra una coincidencia imprime el nombre del objeto para
  ! el cual se halló.

  ! Para mayor flexibilidad aún, se permite que el programador incluya
  ! una rutina en la propiedad nombre_corto del verbo, por si el nombre
  ! del verbo a imprimir es variable según el momento en que se llame.
  ! Si existe nombre_corto para el verbo en cuestión, se ejecuta dicha rutina
  ! de lo contrario se imprime el nombre de ese verbo sin más.

  ! Ver SpanishG.h para ejemplos de declaración de verbos irregulares.

  objectloop (i ofclass VerboIrregular)
   if (WordInProperty(v, i, imperativo)) {
     if (i.&short_name~=0) return(PrintOrRun(i, short_name, 1));
     else { print (name) i; rtrue;}}
  rfalse;
];

!  LanguageVerbLikesAdverb is called by PrintCommand when printing an UPTO_PE
!  error or an inference message.  Words which are intransitive verbs, i.e.,
!  which require a direction name as an adverb ('walk west'), not a noun
!  ('I only understood you as far as wanting to touch /the/ ground'), should
!  cause the routine to return true.

[ LanguageVerbLikesAdverb w;
    if (w == 'vete' or 've' or 'camina' or
        'anda' or 'corre' or 'vuelve' or 'ir')
        rtrue;
    rfalse;
]; 

!  LanguageVerbMayBeName is called by NounDomain when dealing with the 
!  player's reply to a "Which do you mean, the short stick or the long
!  stick?" prompt from the parser. If the reply is another verb (for example,
!  LOOK) then then previous ambiguous command is discarded /unless/
!  it is one of these words which could be both a verb /and/ an
!  adjective in a 'name' property.

[ LanguageVerbMayBeName w;
    if (w == 'long' or 'short' or 'normal'
                    or 'brief' or 'full' or 'verbose')
        rtrue;
    rfalse;
];
-) instead of "Commands" in "Language.i6t".


Section 10 - Printed Inflections

Include (-
! Definimos una función para imprimir el verbo coger. Esto hace más fácil
! la adaptación de los juegos a los dialectos sudamericanos, en los
! que debe usarse "tomar" en lugar de "coger"
! 
! La variable global que elige el dialecto se fija en tiempo de
! ejecución con el meta-verbo "dialecto". También puede fijarse en
! Initialize para que su valor por defecto sea 1.
!
[ coge sufijo;
    if (dialecto_sudamericano)
      print "toma";
    else print "coge";
    if (sufijo ~= 0)
       print (string) sufijo;
!    #ifndef NI_BUILD_COUNT; print (string) sufijo;#endif; !desde I7 no puede usarse 'sufijo'
];

! La siguiente es la versión con la primera letra mayúscula

[ MCoge sufijo;
    if (dialecto_sudamericano)
    print "Toma";
    else print "Coge";
    if (sufijo ~= 0)
       print (string) sufijo;
!    #ifndef NI_BUILD_COUNT; print (string) sufijo;#endif; !desde I7 no puede usarse 'sufijo'
];

! Y finalmente una versión con todo mayúsculas

[ MMCoge sufijo;
    if (dialecto_sudamericano)
    print "TOMA";
    else print "COGE";
    if (sufijo ~= 0)
       print (string) sufijo;
!    #ifndef NI_BUILD_COUNT; print (string) sufijo;#endif; !desde I7 no puede usarse 'sufijo'
];
-) before "Commands" in "Language.i6t".

Include (-
! Funciones para manejar concordancias de género y número en los
! mensajes de respuesta genéricos.
!
! o -> escribe la terminación -o -a -os -as según el género y número
! del objeto recibido, para hacer concordar los adjetivos.
!
! n -> escribe la terminación -"" -n según el número del objeto, para
! hacer concordar el verbo en plural.
!
! esta -> escribe "está" o "están" según el número del objeto.
!
! del -> escribe "del" "de la" "de los" "de las" según el género y
! número del objeto. En realidad, determina qué artículo habría de ir
! y si éste es "el" realiza la contracción "del".
!
! al -> como del, pero con "al" "a la" "a los" "a las".
!
! lo -> Escribe "lo" "la" "le" "los" "las" "les" (proname) según el
! género y número del objeto y según sea animate o no.
!

Constant PARTICULA_TE       = "te";
Constant THOSET__TX      = "esas cosas";
Constant THAT__TX        = "eso";

[ o obj gna;

    gna=GetGNAOfObject(obj);
    switch(gna)
    {
     0,6: print "o";
     1,7: print "a";
     3,9: print "os";
     4,10: print "as";
    }
];    

[ e obj gna;

    gna=GetGNAOfObject(obj);
    switch(gna)
    {
     0,6: print "e";
     1,7: print "a";
     3,9: print "es";
     4,10: print "as";
    }
];


[ n obj;
    if (obj == player) print "s";
    else if (obj has pluralname) print "n";
];

[ s obj;
    if (obj has pluralname) print "s";
];

[ esta obj;
    print "está", (n) obj;
];

[ es obj;
    if (obj has pluralname) print "son";
    else print "es";
];

[ _Es obj;
    if (obj has pluralname) print "Son";
    else print "Es";
];

[ _s obj;
    if (obj has pluralname) print "es";
];

[ el_ obj;
    if (obj hasnt proper) PrefaceByArticle(obj,1,-1);
];

[ un_ obj;
    if (obj hasnt proper) PrefaceByArticle(obj,2,-1);
];


[ el obj;
    print (the) obj;
];

[ _El obj;
    print (The) obj;
];

![ un obj;
!    if (un_(obj)) print " ";
!    print (name) obj;
!];

[ un obj;
!  if (obj has proper) print "a "; ![infsp] ya se incluyó esta linea en el hackeo de Indefart.
  print (a) obj;
];

[ _Un obj; ! indefinido con la primera letra en mayuscula. -Eliuk Blau
  print (A) obj;
];


[ _nombre_ obj;
    print (name) obj;
];

[ numero obj;
    print (number) obj;
];


! "al" y "del" plantean un bonito problema. La contracción debe
! producirse si el artículo es "el", pero esto no se sabe consultando
! el GNA, pues hay palabras como "aguila" que son femeninas y no
! obstante usan "el" como artículo.
! El truquillo consiste en llamar a (the) para averiguar qué artículo
! se imprimiría (pero capturando la salida de ese print y guardándola
! en una variable). Si el artículo en cuestión empieza por 'e', se
! produce la contracción.
!
! Para capturar la salida a una variable, es necesario descender al
! lenguaje ensamblador de la Z machine. Este truco lo aprendí del
! Designers manual (respuesta al ejercicio 96, página 249)
!
[ del_ obj;
    if (obj has proper) {        ! 030305
            print "de ";
            rtrue;
    }
!print " (del) "; ! infsp debug
                
#ifdef TARGET_ZCODE;
    texto_impreso-->0 = 50;
    @output_stream 3 texto_impreso;
    print (the)obj;
    @output_stream -3;
    if (texto_impreso->2 == 'e') print "d";
    else print "de ";
#ifnot; !TARGET_GLULX
    Glulx_PrintAnyToArray(texto_impreso, 50, PrefaceByArticle, obj, 1, -1);
    if (texto_impreso->0 == 'e') print "d";
    else print "de ";
#endif;    
    if (obj hasnt proper) PrefaceByArticle(obj, 1, -1);
];

! Con "al" el truco es más complejo, ya que si el artículo impreso por
! el_ empieza por "e", hay que cambiar esta "e" por una "a". Y si no
! empieza por "e" hay que poner una "a" delante.
! Además debemos capturar el caso de que no se imprima artículo alguno
! (si el objeto proporciona una propiedad "articulos" con cadenas
! vacías).
!------------------------------------------------------------------------------
! ELIUK BLAU: He re-implementado la rutina para permitir que la primera letra
! se imprima en mayuscula si se activa el argumento 'flag' durante la llamada.
[ al_ obj flag; ! ELIUK: 'flag' es usado solo por rutina de impresion (_Al)
    #ifdef TARGET_ZCODE;
      texto_impreso-->0 = 50;
      @output_stream 3 texto_impreso;
      print (the) obj;
      @output_stream -3;
      ! print "^  ";for (i=2:i<50:i++) print (char)texto_impreso->i;print "   "; ! infsp debug
    #ifnot; !TARGET_GLULX
      ! PrintAnyToArray(texto_impreso, 50, PrefaceByArticle, obj, 1, -1);
      Glulx_PrintAnyToArray(texto_impreso, 50, Defart, obj);! 070809 infsp fix: corrige mal funcionamiento con Propios - gracias Eliuk
      ! print "^  ";for (i=0:i<2:i++) print (char)texto_impreso->i;print "   "; ! infsp debug
    #endif; !TARGET_
    
    ! ELIUK: aqui se decide si se pone mayuscula o no
    if (flag) { print "A"; } ! 'flag' activado
    else { print "a"; }      ! 'flag' desactivado

    ! ELIUK: completamos el resto del texto que se imprimira finalmente
    #ifdef TARGET_ZCODE;
      if (texto_impreso->2 == 'e') { print "l "; }
      else {
        print " ";
        if (obj hasnt proper) { PrefaceByArticle(obj, 1, -1); }
      }
    #ifnot; !TARGET_GLULX
      if (texto_impreso->0 == 'e') { print "l "; }
      else {
        print " ";
        if (obj hasnt proper) { PrefaceByArticle(obj, 1, -1); }
      }
    #endif; !TARGET_
];

[ del obj;
    print (del_) obj;
    print (name) obj;
];

[ al obj;
    print (al_) obj;
    print (name) obj;
];

! ELIUK BLAU: Rutina de impresion "A", "Al", "A la", "A los", "A las" con la primera
! letra en mayuscula. Se usa como base el funcionamiento de la rutina al_() de INFSP.
[ _Al obj;
    al_(obj,1); ! con 1 se activa 'flag' para imprimir primera letra en mayuscula
    print (name) obj;
    ! NOTA: SI POSTERIORMENTE SE INTENTA MEJORAR ESTA RUTINA, JUNTO CON al_(),
    ! LA SOLUCION JAMAS DEBE SER IMPRIMIR A UN BUFFER PORQUE LOS RESULTADOS
    ! PUEDEN SER INESPERADOS. LA PROPIA al_() YA IMPRIME A UN BUFFER, ASI QUE
    ! OTRO TRABAJO DEL MISMO TIPO IMPLICARIA TENER QUE CREAR UN NUEVO ARRAY
    ! CON EL QUE TRABAJAR O USAR EL ARRAY COMUN StorageForShortName DE LA
    ! PROPIA LIBRERIA INFORM. EN ESTE ULTIMO CASO ES CUANDO SE PRODUCEN LOS
    ! PROBLEMAS... POR OTRO LADO: CREAR UN NUEVO ARRAY SOLO PARA QUE LO USE
    ! ESTA RUTINA NO TIENE SENTIDO. POR ESO LA NECESIDAD DEL 'flag' EN al_()
];

[ lo obj gna;
    gna=GetGNAOfObject(obj);
    switch(gna)
    {
     0,6: print "lo";
     1,7: print "la";
     3,9: print "los";
     4,10: print "las";
    }
];

! deprecated
![ IsOrAre obj;  !I7 stuffs, in Verbs.i6/GenericVerbSub
!    if (obj == player)             { print "Eres"; return; }
!    if (obj has pluralname)        { print "Son"; return; }
!    print "Es";
!];

-) before "Commands" in "Language.i6t".


Section 12 - Otras rutinas

Include (-
! Cuando el usuario teclea un comando incompleto, es necesario que
! el parser genere un mensaje preguntando por lo que falta,
! pero la forma de preguntarlo depende del verbo. Por ej.:
!
! > coge
! ¿Qué quieres coger?
!
! > mete llave
! ¿Dónde quieres meter la llave?
!
! > orco, saca la botella
! ¿De dónde tiene que sacar el orco la botella?
!
! Cuando el parser tiene que imprimir una respuesta de estas,
! simplemente llama a MLIdioma con el número de mensaje Misc, 48 o
! 49. En esta versión de la librería (6/7) es responsabilidad de
! LanguageLM generar el mensaje completo.
!
! En nuestro caso hemos implementado estos mensajes de forma que
! llaman a IniciarPregunta para que escriba una partícula interrogativa
! como "Donde" "De donde", etc. Si no escribe nada, MLIdioma pone
! "Qué" o "A quién" según el tipo de error, a continuación se escribe
! "quieres" o "tiene que" según quién sea el actor. Se llama a
! LanguageVerb para que escriba el verbo, y finalmente se añade el
! name del objeto directo si lo había, para terminar la pregunta
! cerrando la interrogación.
!
! IniciarPregunta, lo que hace es: 
!
! 1) busca preposiciones en el patrón que ha encajado, si las
! encuentra, la pregunta debe comenzar por alguna partícula
! interrogativa. Por ejemplo, si la línea de gramática hallada era
! "saca" noun "de" noun, se hallará la preposición "de" que nos indica
! que la pregunta ha de comenzar con "¿De dónde ...".
!
! 2) Llama a la función "IdiomaPreguntarPrep" que recibe como
! parámetros la preposición y la acción en curso, para que imprima la
! partícula interrogativa adecuada. Esta función tan sólo debe
! escribir esa partícula.
!
! IdiomaPreguntarPrep llama a su vez a PreguntarPreposicion por si el
! programador añade verbos raros con preposiciones raras que no son
! correctamente manejados por esta rutina. Si PreguntarPreposicion
! existe y retorna distinto de cero, IdiomaPreguntarPrep asumirá
! que la partícula interrogativa ya ha sido escrita por
! PreguntarPreposicion y no hará nada más.
!
[ IdiomaPreguntarPrep prepos action;

    if (PreguntarPreposicion(prepos, action)) return;
!    print "^IPPrep: action: ", (DebugAction)action, "  Prepos: ",(address)prepos,"^"; ! infsp debug 
    switch (prepos)
    {
     'de': 				print "De dónde";
     'en', 'dentro', 'encima': 	print "Dónde";
     'bajo','debajo':		print "Debajo de qué";
     'sobre', 'acerca':		print "Sobre qué";
     'contra': 			print "Contra qué";
     'hacia':				print "Hacia dónde";
     'con':if (action==##Tell or ##Attack)  print "Con quién";
              else print "Con qué";
     'por':if (action==##Ask) 	print "Por qué";
              else print "Por dónde";
     'una', 'un' : 			print "A quién";
     'a//':  switch(action){
           ##Go:          	print "Hacia dónde";
           ##Climb:      	print "Dónde";
           ##ThrowAt, ##Give, ##Show, ##Answer, ##Tell, ##Ask:
				print "A quién";
           ##Search:		print "A través de qué";
           ##Tie: 	        print "A qué"; 
           ##Enter: 		print "A dónde";
           default:         print "A quién";
       };
    }
];


! A partir del patrón que ha construido el parser, se determina cuál
! es la primera preposición usada detrás del verbo.
! Esto será usado por la función IniciarPregunta y por LanguageIsVerb
! [INFSP] Recoding para un mejor comportamiento en caso de lineas de gramaticas complejas
! Ej: 'pon' noun 'en/sobre' noun . Antes usando 'sobre' (segundo token) no andaba.
! (devolvia NULL)

[ AveriguarPreposicion 
    i k p ;

!    print " ",pattern-->(pcount-1)," ^"; ![infsp] debug

    p = NULL;
    for (k=pcount:k>=1:k=k-1){ ! infsp tunnig, para evitar el menos menos que quiebra la sintaxis de Include
!        print "^AP: k:",k; ! infsp debug
       i=pattern-->k;
!        print "^ i:",(address)VM_NumberToDictionaryAddress(i-REPARSE_CODE); ! infsp debug 
       if ( i == PATTERN_NULL) continue;
       if (i>=REPARSE_CODE)
           p=VM_NumberToDictionaryAddress(i-REPARSE_CODE);
    }
    return p;

];


[ AveriguarPrimeraPreposicion
    i k p found;
    p=NULL;
    for (k=pcount:k>=1:k=k-1) ! infsp tunnig, para evitar el menos menos que quiebra la sintaxis de Include
    { 
!     print "^AP: k:",k; ! infsp debug
     i=pattern-->k;
!    print "^ i:",i; ! infsp debug 
   if (pattern-->k == PATTERN_NULL) continue;
!    i=pattern-->k;
        if (i>=REPARSE_CODE)
        {
        i=VM_NumberToDictionaryAddress(i-REPARSE_CODE);
        p=i;    ! nos quedamos con la primera
        found=k;
        }
    }
!    print "APP: Primera prep: ",(address) p; ! infsp debug
!    print " / found :",found; ! infsp debug
!    print " / pcount :",pcount,"^"; ! infsp debug
    
    if (found==(pcount -1)) return NULL;
    else return p;
];


! Averigua si es necesaria una partícula interrogativa. Llama a
! IdiomaPreguntarPrep para que la imprima.
!
! Retorna 1 si ha sido impresa la partícula interrogativa, y 0 en caso
! contrario, (y entonces la función que la llamó "LanguageLM", sabe
! que es necesario escribir "Qué" o "A quién" ya que en este caso lo
! que faltaba era el objeto directo en lugar del complemento.
!
[ IniciarPregunta
    p;

    print "¿";
    p=AveriguarPreposicion();
    if (p~=NULL) {
      IdiomaPreguntarPrep(p, action_to_be);
      return 1;
    }
    return 0;
    
];

[ IdiomaImprimirComando from i k spacing_flag prep;

  if (from==0)
  {   i=verb_word;
      LanguageVerb(i);
      from++; spacing_flag = true;
  }
  
! print "^Valor de from: ",from,"^"; ! infsp debug
! print "Valor de pcount: ",pcount,"^"; ! infsp debug
  
  for (k=from:k<pcount:k++){
     i=pattern-->k;
!     print "^IIC: i: ",  i, "^"; ! infsp debug
      if (i == PATTERN_NULL) continue;
!      if (spacing_flag) print (char) ' ';
      if (i == 0 ) { print " ",(string) THOSET__TX; jump TokenPrinted; }
      if (i == 1) { print " ",(string) THAT__TX;   jump TokenPrinted; }
      if (i >= REPARSE_CODE) continue;
      else {
            if (i in compass && LanguageVerbLikesAdverb(verb_word))
                LanguageDirection (i.door_dir); ! the direction name as adverb
            if (i==player) print "te";
            else  {
               prep=AveriguarPrimeraPreposicion();
               switch(prep){
                 'a//': print " ",(al) i;
                 'de': print " ",(del) i;
                 NULL: print " ",(the) i;
                 default: !print " ", (address) prep;
                           print " ",(the) i;
               }
            }
      continue;
      }
      .TokenPrinted;
      spacing_flag = true;
  } ! for
];


! ---------------------------------------------------------------------------
! Otras rutinas de soporte para el AUTOR de Aventuras 

[ TextoLlamativo txt;
    ! Imprime un texto rodeado de asteriscos y en negrita. 
    ! Puedes cambiarlo si quieres que aparezcan en otros formatos.
     VM_Style(ALERT_VMSTY);
!     print "***", (string) txt, "***"; ! [010508] Corregido bug (string)
     print (string) txt; ! infsp fix, los asteriscos ya se ponian en parserm.h
     VM_Style(NORMAL_VMSTY);
];


Constant LIBRARY_SPANISH;       ! for dependency checking.
-)

Section 13 - Otras Acciones


Include (-
! Esto era parte de SpanishG.h -(Gramatica.h) GRAMATICA: Gramática española

#Stub PreguntarPreposicion 0;

#ifdef DEBUG;
  [ ActivarAcentosSub;
    quitacentos = 0;
    "Los acentos no serán eliminados del comando recibido.";
  ];

  [ DesactivarAcentosSub;
    quitacentos = 1;
    "Los acentos serán eliminados del comando recibido, pero sólo en
      las palabras que de otro modo no serían comprendidas.";
  ];
#endif; ! DEBUG

! Elección del dialecto (afecta a la interpretación del
! verbo COGER únicamente)

[ DialectoSub;
  print "Actualmente estás jugando en el dialecto ";
  if (dialecto_sudamericano)
    print "sudamericano";
  else
    print "castellano";
  ". Puedes elegir dialecto usando el comando DIALECTO SUDAMERICANO \
    o bien DIALECTO CASTELLANO.";
];

[ DialectoSudSub;
  dialecto_sudamericano = 2; ! git
  "Elegido dialecto SUDAMERICANO.";
];    

[ DialectoCastSub;
  dialecto_sudamericano = 0;
  "Elegido dialecto CASTELLANO.";
];


[ QuitarSub;
    if (second) <<Remove noun second>>;
    if (noun in player) <<Disrobe noun>>;
    <<Take noun>>;
];

! Algunas lineas de gramatica no incluidas en las SR (lineas que son propias de InformATE)
! [TODO]: a la espera de ser 'transferidas' a SL (Spanish Localization I7 Extension)
! Actualizacion, ahora si andan las Extend, porque se cambio de lugar la inclusion de SpanishG
!   en el codigo de auto.inf (usando Foreign Language en SL y main.i6)

Verb meta 'dialecto'
  *                                   -> Dialecto
  * 'sudamericano'               -> DialectoSud
  * 'castellano'                    -> DialectoCast;

! GotoRoomSub: algunos momios de informATE estaban acotumbrados a hacer >xir 'nombre_habitacion'
! pero, despues de la Build 4S08 no fue posible sino la forma oficial
! >xir 'numero_habitacion' . Ese numero_habitacion se ve haciendo >tree
! Aqui agregamos una variante para poder seguir usando nuestro >xir 'nombre_habitacion'
! (de puro caprichosos que somos) 

#ifdef DEBUG;

[ GotoRoomSub x;  ! para funciones de debug
    x = noun;
    while (parent(x) ~= 0) x = parent(x);
!    print "   Moviendo a ",(the) x,"^";!infsp debug
    PlayerTo(x);
];   
  
 Verb meta 'acentos'
    *                                 -> ActivarAcentos
    * 'on'/'si'                          -> ActivarAcentos
    * 'off'/'no'                      -> DesactivarAcentos;

  Verb 'traza' = 'trace';

  Verb 'acciones' = 'actions';

  Verb 'aleatorio' 'predecible' = 'random' ;

  Verb 'xroba' = 'purloin';

  Verb meta 'xmueve'
	* scope=testcommandnoun ’a//’ scope=testcommandnoun -> XAbstract;

  Verb 'arboljuego' 'xarbol' = 'tree';

  Verb meta 'xir'
    * scope=testcommandnoun  -> GotoRoom;

  Verb 'irdonde' = 'gonear';

  Verb 'alcance' = 'scope' ;

  Verb 'xverbo' = 'showverb';

  Verb 'xobjeto' =  'showme';

  Verb 'relaciones'= 'relations';
  
  Verb 'reglas' = 'rules';
  
  Verb 'escenas' =  'scenes';
  
#endif;  ! DEBUG

-) after "Grammar" in "Output.i6t".


Section 14 - Hora en palabras





Section 15 - Spanish Banner

[just replacement "by" --> "por"]

Include (-

[ Banner;
		!print (string) Story;!deprecated
		!print " / Inform 7 build ", (string) NI_BUILD_COUNT, " ";!deprecated
   BeginActivity(PRINTING_BANNER_TEXT_ACT);
   if (ForActivity(PRINTING_BANNER_TEXT_ACT) == false) {
	   	VM_Style(HEADER_VMSTY);
		TEXT_TY_Say(Story);
		VM_Style(NORMAL_VMSTY);
		new_line;
		TEXT_TY_Say(Headline);
		#ifdef Story_Author;
		!print " by "; TEXT_TY_Say(Story_Author);
    print " por "; TEXT_TY_Say(Story_Author);! infsp hack 'by' - INTER - LOCALISATION
		#endif; ! Story_Author
		new_line;
		VM_Describe_Release();
		print " / Inform 7 build ", (PrintI6Text) NI_BUILD_COUNT, " ";
		print "(I6/v"; inversion;
		print " lib ", (PrintI6Text) LibRelease, ") ";
		#Ifdef STRICT_MODE;
		print "S";
		#Endif; ! STRICT_MODE
		#Ifdef DEBUG;
		print "D";
		#Endif; ! DEBUG
		new_line;
    }
    EndActivity(PRINTING_BANNER_TEXT_ACT);

];
-) instead of "Banner" in  "Printing.i6t". 


Section 16 - PrefaceByArticle Hacked

[for use of rutines [el_], [un_] ]

Include (-

Global short_name_case;

!para q funcione con (el_):
[ PrefaceByArticle obj acode pluralise capitalise  i artform findout artval;
    if (obj provides articles) {
        artval=(obj.&articles)-->(acode+short_name_case*LanguageCases);
        if (capitalise)
            print (Cap) artval, " ";
        else
            print (string) artval, " ";
        if (pluralise) return;
        print (PSN__) obj; return;
    }

    i = GetGNAOfObject(obj);


!    if (pluralise) {
! [infsp]: para q funcione con (el_), se agrego '>0' para el correcto funcionamiento (sino al final imprime el nombre de objeto cuando yo solo quiero imprimir su articulo)
    if (pluralise>0) { ![INFSP] ej, en ListMiscellany 19,[TODO] esto podria resolverse como los italianos
        if (i < 3 || (i >= 6 && i < 9)) i = i + 3;
    }
    i = LanguageGNAsToArticles-->i;

    artform = LanguageArticles
        + 3*WORDSIZE*LanguageContractionForms*(short_name_case + i*LanguageCases);

    #Iftrue (LanguageContractionForms == 2);
    if (artform-->acode ~= artform-->(acode+3)) findout = true;
    #Endif; ! LanguageContractionForms
    #Iftrue (LanguageContractionForms == 3);
    if (artform-->acode ~= artform-->(acode+3)) findout = true;
    if (artform-->(acode+3) ~= artform-->(acode+6)) findout = true;
    #Endif; ! LanguageContractionForms
    #Iftrue (LanguageContractionForms == 4);
    if (artform-->acode ~= artform-->(acode+3)) findout = true;
    if (artform-->(acode+3) ~= artform-->(acode+6)) findout = true;
    if (artform-->(acode+6) ~= artform-->(acode+9)) findout = true;
    #Endif; ! LanguageContractionForms
    #Iftrue (LanguageContractionForms > 4);
    findout = true;
    #Endif; ! LanguageContractionForms

    #Ifdef TARGET_ZCODE;
    if (standard_interpreter ~= 0 && findout) {
        StorageForShortName-->0 = 160;
        @output_stream 3 StorageForShortName;
        if (pluralise) print (number) pluralise; else print (PSN__) obj;
        @output_stream -3;
        acode = acode + 3*LanguageContraction(StorageForShortName + 2);
    }
    #Ifnot; ! TARGET_GLULX
    if (findout) {
        if (pluralise)
            Glulx_PrintAnyToArray(StorageForShortName, 160, EnglishNumber, pluralise);
        else
            Glulx_PrintAnyToArray(StorageForShortName, 160, PSN__, obj);
        acode = acode + 3*LanguageContraction(StorageForShortName);
    }
    #Endif; ! TARGET_

    Cap (artform-->acode, ~~capitalise); ! print article
    if (pluralise) return;
    print (PSN__) obj;
];

-) instead of "Object Names II" in  "Printing.i6t".

Section 17 - IndefArt Hacked

[! [infsp] Indefart: se agregó el "a " en caso de nombre propio " a Mamá"]

Include (-
Replace IndefArt;
-) after "Definitions.i6t". 

Include (-
[ IndefArt obj i;
	if (obj == 0) { LIST_WRITER_INTERNAL_RM('Y'); rtrue; }
    i = indef_mode; indef_mode = true;
    if (obj has proper) { indef_mode = NULL; print "a ",(PSN__) obj; indef_mode = i; return; }!infsp
    if ((obj provides article) && (TEXT_TY_Compare(obj.article, EMPTY_TEXT_VALUE) ~= 0)) {
        PrintOrRun(obj, article, true); print " ", (PSN__) obj; indef_mode = i;
        return;
    }
    PrefaceByArticle(obj, 2); indef_mode = i;

];
-) after "Object Names III" in "Printing.i6t".

Section 18 - Checkin I7 Build version - Not for release 

A startup rule:
	Check I7 Version.

To Check I7 Version: (- chkI7V(); -).

Include (-
#ifdef DEBUG;
Array  buffer_nversion string 7;    ! infsp debug: Buffers for cheking I7 IDE correct version
Array  buffer_bversion string 7;    ! See LanguageInitialise, below.

Constant NI_NEEDED_VERSION "6L02";
! LanguageInitialise: ojo que aqui aun no se seteo el I/O para Glulx (no andarian los prints y demás).

[ chkI7V;				!infsp debug : check correct I7 Build Version
!     print "LanguageInitialise^^"; 
   if ( ~~CheckI7version() ){
     print "^^^ INFSP ATENCION : Este juego fue compilado con una version distinta de
        Inform (distinta a la soportada por la extensión Spanish).^Asegurate de compilar con la ";
     ImprimeTodoElBuffer(buffer_nversion);
     print ". ^^^"; 
   }

];

[ CheckI7version	l i;
	l = VM_PrintToBuffer(buffer_nversion, 4, NI_NEEDED_VERSION);
	l = VM_PrintToBuffer(buffer_bversion, 4, NI_BUILD_COUNT);    
	for (i=WORDSIZE:i<WORDSIZE+4:i++)	! comparar caracter x caracter:
		if (buffer_bversion->i ~= buffer_nversion->i) rfalse;
		rtrue;
];
#endif; ! DEBUG
-) after "Definitions.i6t".


Spanish Language ends here.