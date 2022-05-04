CREATE OR REPLACE PACKAGE xx_test_coa AS
/* $Header: $ */
/*#
* This package returns different data from Financials (GL).
* @rep:scope public
* @rep:product gl
* @rep:displayname xx_test_coa
* @rep:lifecycle active
* @rep:compatibility S
* @rep:category BUSINESS_ENTITY GL_CHART_OF_ACCOUNTS
*/

/*#
* Returns COA
* @param P_VALUE_SET_NAME varchar2 Value Set Name
* @return FLEX_VALUES
* @rep:scope public
* @rep:lifecycle active
* @rep:displayname Return COA
*/
FUNCTION get_coa (P_VALUE_SET_NAME IN VARCHAR2) RETURN varchar2;

TYPE OFS_COA_t IS record (
    OFS_INSTANCE VARCHAR2(50) ,
    SEGMENT_NAME VARCHAR2(60) ,
	COA_CODE VARCHAR(25)  ,
    COA_VALUE VARCHAR(240) ,
    RELATIONSHIP VARCHAR(25) ,
    REMARK VARCHAR2(250),
	STATUS VARCHAR2(25)  );
TYPE OFS_COA_TBL IS TABLE OF OFS_COA_t
 INDEX BY BINARY_INTEGER;
/*#
* Returns COA Detail
* @param P_VALUE_SET_NAME varchar2 Value Set Name
* @param P_OFS_COA_TBL OFS_COA_TBL OFS_COA_TBL
* @rep:scope public
* @rep:lifecycle active
* @rep:displayname Return COA Detail
*/


PROCEDURE get_coa_details (P_VALUE_SET_NAME IN VARCHAR2, P_OFS_COA_TBL OUT
OFS_COA_TBL);


END xx_test_coa;


