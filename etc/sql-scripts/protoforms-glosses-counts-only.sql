/* 27-01-2022 PPh Lexical innovation protoforms for semantic tagging
 * - Tag ones with highest reflex count first
 * - Try to introduce some measure of geographical / subgroup distribution too,
 *   either in this query or with Python or R scripting. But I can do this
 *   with the full sheet, this one is just for the tagging.
 * - Put it into a Google Sheet and recruit Ben V and/or someone else to help.
 */

SELECT DISTINCT
	cs.Form AS ProtoForm,
	cs.cldf_description AS ProtoFormGloss,
	cs.Proto_Language AS ProtoLanguage,
	COUNT(ft.cldf_form) OVER (PARTITION BY cs.Form) AS ReflexCount
FROM
	CognatesetTable cs
INNER JOIN CognateTable ct ON ct.cldf_cognatesetReference = cs.cldf_id 
INNER JOIN FormTable ft ON ft.cldf_id = ct.cldf_formReference
WHERE (ProtoLanguage = "PPh" OR ProtoLanguage = "PPH")
ORDER BY ReflexCount DESC, ProtoForm ASC