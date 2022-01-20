SELECT 
	ft.cldf_form as Form, pt.cldf_name as Gloss , lt.Location , lt.Glottolog_Name as GlottologName, lt.cldf_name as ACDName,
	ct2.Form as ProtoForm , ct2.cldf_description as ProtoFormGloss , ct2.Proto_Language 
FROM FormTable ft 
inner join LanguageTable lt on lt.cldf_id = ft.cldf_languageReference 
inner join ParameterTable pt on pt.cldf_id = ft.cldf_parameterReference 
inner join CognateTable ct on ct.cldf_formReference = ft.cldf_id 
inner join CognatesetTable ct2 on ct2.cldf_id = ct.cldf_cognatesetReference 
where (ct2.Form like "%d%" or ct2.Form like "%z%") 
AND lt.cldf_glottocode IN (
	"atii1237", "mala1492", "baro1255", "bata1315", "yami1257", "ivat1242", "yami1254", "ibat1238", "sout2903", "basc1238", "babu1242", 
	"bili1253", "tbol1241", "blaa1241", "koro1310", "sara1326", "tbol1240", "cent2081", "west2549", "sout2904", "tiru1241", "gian1241", 
	"cent2080", "pamp1243", "remo1247", "samb1319", "amba1267", "abel1234", "aben1249", "boto1242", "ayta1251", "samb1320", "bata1297", 
	"maga1270", "maga1263", "magi1241", "tina1255", "boli1256", "tina1248", "sant1416", "ibaa1241", "masi1267", "grea1284", "cent2246", 
	"taga1280", "taga1269", "taga1270", "mari1431", "taya1253", "tana1284", "luba1251", "bata1299", "bata1300", "bula1257", "mani1245", 
	"fili1244", "kasi1256", "bisa1268", "cebu1242", "mind1257", "boho1237", "cebu1243", "leyt1237", "sout3175", "butu1243", "butu1244", 
	"taus1251", "suri1274", "suri1273", "jaun1245", "cant1244", "nucl1547", "tand1258", "natu1247", "unun9997", "ataa1240", "cent2263", 
	"romb1245", "romb1246", "basi1248", "sibu1251", "peri1261", "bant1293", "capi1240", "hili1240", "nucl1546", "kawa1279", "bant1287", 
	"kari1307", "capi1239", "poro1253", "masb1239", "masb1238", "masb1237", "wara1304", "sama1315", "kina1252", "wara1300", "nort2882", 
	"sama1301", "wara1247", "bayb1234", "wara1299", "west2820", "inon1237", "alca1237", "disp1238", "bula1256", "look1237", "kina1255", 
	"kina1250", "lamb1274", "miag1237", "anin1241", "pand1266", "hamt1248", "poto1251", "guim1241", "sulo1237", "kuya1251", "cuyo1237", 
	"data1234", "calu1238", "semi1263", "rata1245", "sant1420", "nucl1545", "akla1240", "mala1491", "buru1327", "alca1238", "akla1241", 
	"negr1236", "karo1299", "maga1264", "bant1288", "odio1237", "sima1260", "siba1241", "bant1289", "cala1257", "mans1261", "kama1363", 
	"nort2881", "sout2910", "dava1245", "east2477", "mans1262", "kara1489", "west2552", "taga1268", "kaga1259", "kala1388", "isam1242", 
	"piso1238", "tumu1243", "lact1237", "kaga1255", "mama1275", "biko1240", "inag1234", "mtir1236", "isar1235", "mtir1235", "inla1266", 
	"irig1242", "alba1269", "buhi1243", "liga1237", "libo1242", "dara1251", "oass1237", "coas1315", "sout2912", "cent2087", "lega1251", 
	"naga1402", "nort2883", "alab1255", "alab1246", "cama1250", "goro1257", "mong1346", "pono1240", "mong1342", "pasi1256", "dumo1238", 
	"lola1249", "goro1273", "lola1250", "kaid1239", "bola1251", "kaid1240", "suwa1241", "bund1256", "buol1237", "goro1259", "tila1238", 
	"east2479", "limb1269", "goro1260", "west2556", "bint1245", "bola1252", "atin1241", "nucl1549", "pala1354", "nort3185", "bata1317", 
	"bata1301", "cent2090", "tagb1258", "sout3165", "molb1238", "nucl1738", "cent2091", "broo1240", "broo1239", "sout2917", "sout2916", 
	"molb1237", "taut1234", "sout2915", "buhi1244", "buhi1245", "bata1318", "west2559", "east2482", "hanu1241", "binl1237", "waig1245", 
	"kaga1257", "wawa1249", "mano1276", "cent2255", "east2778", "east2742", "cent2088", "mati1250", "tigw1237", "kula1279", "mati1251", 
	"tala1286", "atam1240", "east2478", "diba1242", "agus1235", "suri1270", "umay1237", "adga1237", "raja1254", "west2829", "west2554", 
	"ilia1236", "livu1240", "pule1237", "arka1238", "west2555", "ilen1237", "pula1266", "kiri1255", "obom1235", "arak1253", "kida1237", 
	"magp1237", "sout2913", "sara1347", "cota1241", "tasa1241", "blit1237", "sara1327", "gove1241", "taga1272", "nort2884", "kaga1256", 
	"kina1254", "cina1236", "buki1251", "binu1244", "higa1237", "suba1253", "west2811", "west2557", "west2558", "koli1253", "nucl1726", 
	"east2769", "cent2089", "east2481", "east2694", "nort2885", "dika1237", "dapi1237", "salo1238", "lapu1236", "umir1236", "pala1348", 
	"angl1263", "dana1253", "mara1404", "iran1262", "saba1284", "laha1256", "kota1282", "phil1247", "magu1243", "laya1254", "taga1271", 
	"ilud1237", "biwa1242", "sibu1252", "kala1389", "cala1258", "bara1368", "agut1237", "mina1272", "tons1239", "nort2886", "nort2887", 
	"tond1251", "remb1251", "nucl1550", "kaka1268", "tons1240", "liku1244", "kala1390", "kaud1237", "airm1241", "maum1238", "tomb1243", 
	"tara1316", "tomo1245", "tont1239", "lang1325", "sond1251", "tomp1242", "nort3238", "unun9992", "dica1235", "arta1239", "ilok1237", 
	"nort3187", "dupa1235", "tang1350", "pena1263", "pala1346", "baro1254", "bolo1267", "camo1251", "yaga1257", "roso1237", "vall1250", 
	"sant1418", "sant1419", "nucl1755", "para1320", "para1306", "pala1347", "agta1234", "casi1235", "caga1241", "isna1241", "kara1488", 
	"baya1258", "cala1256", "tali1263", "diba1241", "iban1268", "mala1534", "adas1235", "east2476", "west2551", "gadd1245", "cent2084", 
	"itaw1240", "caga1242", "gadd1244", "gada1258", "yoga1237", "iban1267", "sout2909", "nort2880", "atta1244", "pamp1244", "fair1238", 
	"pudt1235", "meso1254", "sout3211", "sout2907", "ilon1239", "iyon1237", "egon1237", "ibal1242", "abak1243", "ital1283", "west2550", 
	"pang1290", "nucl1542", "kall1244", "kele1259", "yatu1237", "bayn1237", "ahin1234", "tino1235", "kaya1320", "kara1487", "iwak1237", 
	"ibal1244", "kaba1284", "dakl1237", "boko1268", "cent2296", "nucl1754", "ifug1247", "amga1235", "burn1237", "bana1290", "tuwa1243", 
	"hapa1237", "hung1279", "laga1242", "bata1319", "mayo1262", "bata1298", "nucl1544", "ayan1239", "ducl1237", "bont1246", "kank1245", 
	"kank1243", "guin1257", "mank1255", "baku1262", "kapa1253", "maen1236", "maen1235", "nort2877", "bont1247", "cent2292", "guin1256", 
	"sada1241", "bayy1237", "fina1242", "sout3368", "east2881", "lias1237", "kada1287", "barl1240", "isin1239", "bala1310", "kali1310", 
	"kali1311", "masa1325", "moya1235", "masa1307", "masa1308", "masa1309", "nort3226", "limo1248", "nort3231", "maba1279", "bana1288", 
	"guba1246", "bana1289", "mali1281", "cent2282", "lubu1243", "balb1237", "guin1255", "lubu1244", "bala1309", "able1237", "sout3203", 
	"butb1235", "sout3207", "lowe1412", "tina1249", "pina1250", "mina1271", "madu1248", "sout2908", "mall1247", "ting1252", "bang1366", 
	"suma1265", "itne1252", "bino1237", "inla1260", "nort2875", "sout2905", "nort2873", "tady1237", "alan1249", "iray1237", "abra1237", 
	"pala1345", "sant1417", "pagb1237", "pamb1244", "alag1243", "sang1335", "sout3155", "bant1286", "rata1244", "nort3174", "tala1285", 
	"lira1237", "awit1237", "aran1264", "nenu1237", "kabu1255", "beoo1241", "essa1237", "sout2902", "dapa1237", "nort2871", "sang1336", 
	"siau1244", "tama1333", "mang1409", "nort2872", "sout2900", "sang1337", "sara1325", "mind1256"
)	

	