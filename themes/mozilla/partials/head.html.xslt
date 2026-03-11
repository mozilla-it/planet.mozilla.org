<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:planet="http://planet.intertwingly.net/"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="atom planet xhtml">
  <xsl:template name="head">
    <xsl:param name="page-title"/>
    <head>
      <title>
        <xsl:choose>
          <xsl:when test="$page-title">
            <xsl:value-of select="$page-title"/> |
          </xsl:when>
        </xsl:choose>
        <xsl:value-of select='atom:title'/>
      </title>
      <meta charset='utf-8'/>
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <meta name='generator' content='{atom:generator}'/>
      <meta name='description' content='Follow the pulse of the Mozilla project. Aggregated updates from the developers, designers, and volunteers building a better internet.' />
      <meta property="og:site_name" content="Planet Mozilla" />
      <meta property="og:title" content="Planet Mozilla" />
      <meta property="og:description" content="Follow the pulse of the Mozilla project. Aggregated updates from the developers, designers, and volunteers building a better internet." />
      <meta property="og:image" content="https://planet.mozilla.org/img/planet_banner.png" />
      <meta name="twitter:card" content="summary_large_image" />
      <meta name="twitter:creator" content="@mozilla" />
      <meta property="twitter:title" content="Planet Mozilla" />
      <meta property="twitter:image" content="https://planet.mozilla.org/img/planet_banner.png" />
      <link href='assets/css/fonts.css' rel='stylesheet' type='text/css'/>
      <link href='assets/css/planet.css' rel='stylesheet' type='text/css'/>
      <link rel="apple-touch-icon" type="image/png" sizes="180x180" href="assets/img/apple-touch-icon.png" />
      <link rel="icon" type="image/png" sizes="196x196" href="assets/img/favicon-196x196.png" />
      <link rel="shortcut icon" href="favicon.ico" />
      <xsl:if test='atom:link[@rel="self"]/@type'>
        <link rel='alternate' href='{atom:link[@rel="self"]/@href}'
          title='{atom:title/text()}' type='{atom:link[@rel="self"]/@type}'/>
      </xsl:if>
      <script defer="defer" type="text/javascript" src="assets/js/app.js">
        <xsl:comment><!--HTML Compatibility--></xsl:comment>
      </script>
    </head>
  </xsl:template>
</xsl:stylesheet>
