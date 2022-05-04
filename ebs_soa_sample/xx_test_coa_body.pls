create or replace
PACKAGE BODY xx_test_coa AS

  FUNCTION get_coa (P_VALUE_SET_NAME IN VARCHAR2) RETURN varchar2 AS
  v_flex_value    varchar2(100);

  BEGIN

SELECT
    ffv.FLEX_VALUE
    into v_flex_value
FROM
    fnd_flex_values      ffv,
    fnd_flex_value_sets  ffvs
WHERE
        ffv.flex_value_set_id = ffvs.flex_value_set_id
    AND ffvs.flex_value_set_name = P_VALUE_SET_NAME
    AND ROWNUM = 1;

    RETURN v_flex_value;

  EXCEPTION
    WHEN no_data_found THEN
      RETURN -99;
    WHEN too_many_rows THEN
      RETURN -90;
  END get_coa;

PROCEDURE get_coa_details (P_VALUE_SET_NAME IN VARCHAR2, P_OFS_COA_TBL OUT
OFS_COA_TBL) AS


 l_return_tbl OFS_COA_TBL;
 l_return_tbl_null OFS_COA_TBL;
 l_count NUMBER ：=1;
 l_instance_name varchar2(20) :='KS OFS';
 CURSOR my_cur (P_VALUE_SET_NAME IN VARCHAR2)
 IS
 SELECT
    l_instance_name OFS_INSTANCE ,P_VALUE_SET_NAME SEGMENT_NAME,ffv.flex_value COA_CODE,ffv.description COA_VALUE,00 RELATIONSHIP,'' REMARK,decode(ffv.enabled_flag,'Y','ACTIVE','DELETE') STATUS
FROM
    fnd_flex_values_vl      ffv,
    fnd_flex_value_sets  ffvs
WHERE
        ffv.flex_value_set_id = ffvs.flex_value_set_id
    AND ffvs.flex_value_set_name = P_VALUE_SET_NAME;
 BEGIN
 FOR rec IN my_cur (P_VALUE_SET_NAME)
 LOOP
 l_return_tbl (l_count).OFS_INSTANCE := rec.OFS_INSTANCE;
 l_return_tbl (l_count).SEGMENT_NAME := rec.SEGMENT_NAME;
 l_return_tbl (l_count).COA_CODE := rec.COA_CODE;
 l_return_tbl (l_count).COA_VALUE := rec.COA_VALUE;
 l_return_tbl (l_count).RELATIONSHIP :=
rec.RELATIONSHIP;
 l_return_tbl (l_count).REMARK := rec.REMARK;
 l_return_tbl (l_count).STATUS := rec.STATUS;

 l_count := l_count + 1;
 END LOOP;
 P_OFS_COA_TBL:= l_return_tbl;
 EXCEPTION
 WHEN NO_DATA_FOUND
 THEN
 P_OFS_COA_TBL:= l_return_tbl_null;
 WHEN TOO_MANY_ROWS
 THEN
 P_OFS_COA_TBL:=l_return_tbl_null;
 END get_coa_details;

END xx_test_coa;
