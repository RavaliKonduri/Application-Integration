<?xml version="1.0" encoding="UTF-8" ?>
<!--
   ITS 462 Final project
   
   Author: Ravali Pothepalli 
   Date:   4/27/2018 

   Filename: Sales.xsl
   Supporting Files: 
-->
<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="Res" select="document('Restaurants.xml')/restaurants/restaurant" />
  <xsl:variable name="months" select="report/sales[not(@month=preceding::sales/@month)]" />
  <xsl:variable name="sales" select="report/sales"></xsl:variable>
  
    <xsl:output method="html"
     doctype-system="about:legacy-compat"
     encoding="UTF-8"
     indent="yes" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Restaurants and Sales</title>
      </head>
      <body>
        <h1>Total Revenue</h1>
        <table width="100%" border="1" style="margin-top: -200px">
      <tr>
        <th>Restaurant</th>
        <xsl:for-each select="report/sales[not(@month=preceding::sales/@month)]">
          <th>
            <xsl:value-of select="@month"/>
          </th>
        </xsl:for-each>
        <th>Total</th>
      </tr>
            <xsl:for-each select="$Res">
              <xsl:variable name="rid" select="@ID" />
              <br />
              <tr>
                <th>
                  <center>
                    <!-- Restaurant Information -->
                    <xsl:value-of select="address" /> <br />
                    <xsl:value-of select="city" />,
                    <xsl:value-of select="state" />&#160;
                    <xsl:value-of select="zip" /> <br/>
                    <xsl:value-of select="phone" /><br/>
                    Restaurant Manager:<xsl:value-of select="manager" />
                  </center>
                </th>
                
                <!-- Monthly Total of Restaurant -->
                <xsl:for-each select="$months">
                  <xsl:call-template name="sum">
                        <xsl:with-param name="mth" select="@month" />
                        <xsl:with-param name="id" select="$rid" />
                  </xsl:call-template>
                    
                </xsl:for-each>
                
                <!-- Overall Total of Restaurant -->
                <xsl:call-template name="resTotal">
                    <xsl:with-param name="id" select="$rid" />
                </xsl:call-template>
                
              </tr>
            </xsl:for-each>

          <tr>
            <th>ALL RESTAURANTS</th>
            <!-- Monthly Total of Restaurant -->
            <xsl:for-each select="$months">
              <xsl:call-template name="monthTotal">
                <xsl:with-param name="mth" select="@month" />
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- Overall total for all the restaurants -->
            <xsl:call-template name="overAllTotal">
            </xsl:call-template>
          </tr>
          </table>
      </body>
    
    </html>
  </xsl:template>

  <!-- Template to compute the Sum of a Restaurant for a given Month - The Restaurant is 
       Identified by the ID -->
  <xsl:template name="sum">
    <xsl:param name="mth" />
    <xsl:param name="id" />
    <td>
      <xsl:value-of select="format-number(sum($sales[@month = $mth and @ID = $id]/@revenue), '$#,##0')"/>
    </td>
  </xsl:template>

  <!-- Template to compute the Sum of Restaurant for all the months -->
  <xsl:template name="resTotal">
    <xsl:param name="id" />
    <td>
      <xsl:value-of select="format-number(sum($sales[@ID = $id]/@revenue), '$#,##0')"/>
    </td>
  </xsl:template>

  <!-- Template to compute the Sum of all the Restaurants for a Given Month -->
  <xsl:template name="monthTotal">
    <xsl:param name="mth" />
    <td>
      <xsl:value-of select="format-number(sum($sales[@month = $mth]/@revenue), '$#,##0')"/>
    </td>
  </xsl:template>

  <!-- Template to compute the of all the Restaurants for all the months. -->
  <xsl:template name="overAllTotal">
    <td>
      <xsl:value-of select="format-number(sum($sales/@revenue), '$#,##0')"/>
    </td>
  </xsl:template>


</xsl:stylesheet>


