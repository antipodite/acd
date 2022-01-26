/* Philippines protoforms Jan 18 2022
   ----------------------------------
    Looking for patterns of overlapping distribution of innovated protoforms 
    indicating networks of borrowing.
    
    Note that many languages have several reflexes listed, sometimes with
    different meanings, sometimes with the same meaning and often distinguished
    only by morphological affixes. How should we deal with these in terms of the
    summary statistics?
    
    For the purposes of the map it's probably OK if I just query the presence or
    absence of reflex in some protoform X in some language A.
    
    Then we need to know what lower level subgrouping affiliation each language 
    has, will need to do this with a Python script to query Pyglottolog for the 
    subgrouping tree.
    
    I also wonder about "PPh" in the protolanguage field - does this unambiguously
    mean that the word is reconstructable to PPh or just that this is assumed?
    What was Blust's reasoning here? Like if when I insert the subgrouping data
    with Pyglottolog and reflexes of protoform X are only found in a certain
    subgroup, should this not mean that protoform X is only reconstructable to
    this subgroup? Try it and see
    
    BTW, even if I don't get the automatic semantic tagging working in time I can
    just tag the first hundred or so reflexes by hand using the WLD fields and
    see if any patterns emerge. This could also be useful for some kind of machine
    learning tagger as training data
*/

SELECT DISTINCT 
	ct2.Form as ProtoForm,
	ct2.cldf_description as ProtoFormGloss,
	ft.cldf_form as Reflex,
	pt.cldf_name as ReflexGloss,
	lt.Glottolog_Name as GlottologName,
	lt.cldf_name as ACDName,
	lt.cldf_glottocode as GlottoCode,
	ct2.Proto_Language as ProtoLanguage,
	COUNT(ft.cldf_form) OVER (PARTITION BY ct2.Form) AS ReflexCount,
	lt.cldf_latitude AS Latitude,
	lt.cldf_longitude AS Longitude
FROM FormTable ft
INNER JOIN LanguageTable lt on lt.cldf_id = ft.cldf_languageReference 
INNER JOIN CognateTable ct on ct.cldf_formReference = ft.cldf_id
INNER JOIN CognatesetTable ct2 on ct2.cldf_id = ct.cldf_cognatesetReference
INNER JOIN ParameterTable pt on pt.cldf_id = ft.cldf_parameterReference 
WHERE (ProtoLanguage = "PPh" OR ProtoLanguage = "PPH")
GROUP BY ACDName, ProtoForm -- only one unique reflex per language
ORDER BY ReflexCount DESC, Protoform ASC, ACDName ASC