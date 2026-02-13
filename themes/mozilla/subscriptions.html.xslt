<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:planet="http://planet.intertwingly.net/"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="atom planet xhtml">
  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:param name="page-title" select="'Subscriptions'"/>

  <xsl:include href="partials/head.html.xslt" />
  <xsl:include href="partials/navbar.html.xslt" />
  <xsl:include href="partials/sidebar.html.xslt" />

  <xsl:template match="atom:feed">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:call-template name="head">
        <xsl:with-param name="page-title" select="$page-title"/>
      </xsl:call-template>
      <body>
        <xsl:call-template name="navbar" />
        <div class="main-container">
          <div class='main-content'>
            <h1 class="h3">Subscriptions</h1>
            <p>
              To request ..., visit our documentation page on
              <a href="https://wiki.mozilla.org/Planet_Mozilla">Mozilla Wiki</a>.
            </p>
            <label for="filter-subscription-list">Filter subscription list:</label>
            <input type="text" placeholder="Find a subscription" id="filter-subscription-list" />
            <ul id="subscription-list" class="menu vertical">
              <xsl:for-each select="planet:source">
                <xsl:sort select="planet:name"/>
                <li class="menu-item card">
                  <span class="u-flex-grow">
                    <xsl:value-of select="planet:name"/>
                  </span>
                  <a>
                    <xsl:if test="atom:link[@rel='alternate']/@href">
                      <xsl:attribute name="href">
                        <xsl:value-of select="atom:link[@rel='alternate']/@href"/>
                      </xsl:attribute>
                    </xsl:if>
                    Website
                  </a>
                  <a>
                    <xsl:choose>
                      <xsl:when test="planet:http_location">
                        <xsl:attribute name="href">
                          <xsl:value-of select="planet:http_location"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:when test="atom:link[@rel='self']/@href">
                        <xsl:attribute name="href">
                          <xsl:value-of select="atom:link[@rel='self']/@href"/>
                        </xsl:attribute>
                      </xsl:when>
                    </xsl:choose>
                    Feed
                  </a>
                </li>
              </xsl:for-each>
            </ul>
          </div>
          <xsl:call-template name="sidebar" />
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
