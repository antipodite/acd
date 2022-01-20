SELECT 
	ft.cldf_form as Form,
	pt.cldf_name as Gloss,
	lt.Location,
	lt.Glottolog_Name as GlottologName,
	lt.cldf_name as ACDName,
	ct2.Form as ProtoForm,
	ct2.cldf_description as ProtoFormGloss,
	ct2.Proto_Language 
FROM FormTable ft 
	inner join LanguageTable lt on lt.cldf_id = ft.cldf_languageReference 
	inner join ParameterTable pt on pt.cldf_id = ft.cldf_parameterReference 
	inner join CognateTable ct on ct.cldf_formReference = ft.cldf_id 
	inner join CognatesetTable ct2 on ct2.cldf_id = ct.cldf_cognatesetReference 
WHERE ct2.Proto_Language = "PPh"
