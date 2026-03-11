<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:planet="http://planet.intertwingly.net/"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="atom planet xhtml">
  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:param name="page-title" select="'Homepage'"/>

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
            <h1 class="h3">Latest News</h1>
            <!-- START Entries -->
            <xsl:for-each select='atom:entry'>
              <article class="post feed-{atom:source/planet:css-id}">

                <xsl:if test="@xml:lang">
                  <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                  </xsl:attribute>
                </xsl:if>

                <!-- Entry header -->
                <header>
                  <p>
                    <span class="post-source">
                      <xsl:if test="atom:source/atom:link[@rel='alternate']/@href">
                        <xsl:attribute name="href">
                          <xsl:value-of
                            select="atom:source/atom:link[@rel='alternate']/@href"/>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:attribute name="title">
                        <xsl:value-of select="atom:source/atom:title"/>
                      </xsl:attribute>
                      <xsl:value-of select="atom:source/planet:name"/>
                    </span>
                  </p>

                  <!-- entry title -->
                  <h2 class="post-title">
                    <xsl:if test="string-length(atom:title) &gt; 0">
                      <a href="{atom:link[@rel='alternate']/@href}">
                        <xsl:if test="atom:title/@xml:lang != @xml:lang">
                          <xsl:attribute name="xml:lang" select="{atom:title/@xml:lang}"/>
                        </xsl:if>
                        <xsl:value-of select="atom:title"/>
                      </a>
                    </xsl:if>
                  </h2>

                  <!-- entry metadata -->
                  <p class="post-metadata">
                    <xsl:choose>
                      <xsl:when test="atom:author/atom:name">
                        <xsl:if test="not(atom:link[@rel='license'] or
                                          atom:source/atom:link[@rel='license'] or
                                          atom:rights or atom:source/atom:rights)">
                          <xsl:text> By </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="atom:author/atom:name"/>
                        <xsl:text> on </xsl:text>
                      </xsl:when>
                      <xsl:when test="atom:source/atom:author/atom:name">
                        <xsl:if test="not(atom:link[@rel='license'] or
                                          atom:source/atom:link[@rel='license'] or
                                          atom:rights or atom:source/atom:rights)">
                          <xsl:text> By </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="atom:source/atom:author/atom:name"/>
                        <xsl:text> on </xsl:text>
                      </xsl:when>
                    </xsl:choose>
                    <time datetime="substring(atom:updated,1,10)">
                      <xsl:value-of select="atom:updated/@planet:format"/>
                    </time>
                  </p>
                </header>

                <!-- entry content -->
                <div class="post-content">
                  <xsl:choose>
                    <xsl:when test="atom:content">
                      <xsl:apply-templates select="atom:content"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:apply-templates select="atom:summary"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </div>
              </article>
            </xsl:for-each>
            <!-- END Entries -->
          </div>
          <xsl:call-template name="sidebar" />
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- xhtml content -->
  <xsl:template match='atom:content/xhtml:div | atom:summary/xhtml:div'>
    <xsl:copy>
      <xsl:if test='../@xml:lang and not(../@xml:lang = ../../@xml:lang)'>
        <xsl:attribute name='xml:lang'>
          <xsl:value-of select='../@xml:lang'/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name='class'>content</xsl:attribute>
      <xsl:apply-templates select='@*|node()'/>
    </xsl:copy>
  </xsl:template>

  <!-- plain text content -->
  <xsl:template match='atom:content/text() | atom:summary/text()'>
    <div class='content' xmlns='http://www.w3.org/1999/xhtml'>
      <xsl:if test='../@xml:lang and not(../@xml:lang = ../../@xml:lang)'>
        <xsl:attribute name='xml:lang'>
          <xsl:value-of select='../@xml:lang'/>
        </xsl:attribute>
      </xsl:if>
      <xsl:copy-of select='.'/>
    </div>
  </xsl:template>

  <!-- Remove stray atom elements -->
  <xsl:template match='atom:*'>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Feedburner detritus -->
  <xsl:template match="xhtml:div[@class='feedflare']"/>

  <!-- Stripe wordpress size-full class -->
  <xsl:template match="xhtml:img[@class='size-full']"/>

  <!-- Stripe servo.org <i> tags leaking in the main layout -->
  <xsl:template match="xhtml:i[@class='fas fa-link']">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Strip site meter -->
  <xsl:template match="xhtml:div[comment()[. = ' Site Meter ']]"/>

  <!-- pass through everything else -->
  <xsl:template match='@*|node()'>
    <xsl:copy>
      <xsl:apply-templates select='@*|node()'/>
    </xsl:copy>
  </xsl:template>

  <!--
    Planet Venus parser is not happy when it encounters an empty HTML element. As
    a result, the style of an empty element can leak in the subsequent elements.
    To prevent this problem, we add an HTML comment inside the empty elements
    except for self-closing void elements.

    See: https://bugzilla.mozilla.org/show_bug.cgi?id=1673540
  -->
  <xsl:template
    match="*[not(normalize-space())
             and not(contains(
               '|area|base|br|col|embed|hr|img|input|link|meta|param|source|track|wbr|',
               concat('|', local-name(), '|')
             ))]">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:comment>empty element</xsl:comment>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
