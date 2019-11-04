/* NAMA TOKEMON */
tokemon(nandamon).
health(100,nandamon).
tipe(fire,nandamon).

tokemon(ayyubmon).
health(110,ayyubmon).
tipe(water,ayyubmon).

tokemon(ciscomon).
health(120,ciscomon).
tipe(leaves, ciscomon).

tokemon(dagomon).
health(130,dagomon).
tipe(grass,dagomon).

tokemon(dikamon).
health(140,dikamon).
tipe(dark,dikamon).

tokemon(fabianmon).
health(150,fabianmon).
tipe(leaves, fabianmon).

tokemon(edomon).
health(160,edomon).
tipe(fire,edomon).

tokemon(gillmon).
health(170,gillmon).
tipe(leaves,gillmon).

tokemon(ojanmon).
health(180,ojanmon).
tipe(grass, ojanmon).

tokemon(rakamon).
health(200,rakamon).
tipe(dark,rakamon).

legendtokemon(harlilimon).
health(500,harlilimon).
tipe(leaves,harlilimon).

legendtokemon(infallmon).
health(600,infallmon).
tipe(dark,infallmon).

legendtokemon(judhimon).
health(700, judhimon).
tipe(water,judhimon).

 /* NORMAL ATTACK */
na(nandamon,20).
na(ayyubmon,25).
na(ciscomon,30).
na(dagomon,35).
na(dikamon,40).
na(fabianmon,35).
na(edomon,30).
na(gillmon,25).
na(ojanmon,20).
na(rakamon,30).
na(harlilimon,60).
na(infallmon,70).
na(judhimon,70).

/* SKILL */
skill(nandamon, 60).
skill(ayyubmon,75).
skill(ciscomon,90).
skill(dagomon,105).
skill(dikamon,120).
skill(fabianmon,105).
skill(edomon,90).
skill(gillmon,75).
skill(ojanmon,60).
skill(rakamon,90).
skill(harlilimon,180).
skill(infallmon,210).
skill(judhimon,200).

/* vs yang memberikan damage lebih dari na */
lawan(fire,leaves).
lawan(water,fire).
lawan(leaves,dark).
lawan(dark,grass).
lawan(grass,water).

