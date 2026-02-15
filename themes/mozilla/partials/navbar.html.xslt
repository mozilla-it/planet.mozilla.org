<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:planet="http://planet.intertwingly.net/"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="atom planet xhtml">
    <xsl:template name="navbar">
        <div class="navbar-container">
          <nav class="navbar">
            <a class="navbar-title"
               href='/'
               title='Back to home page'>
              <xsl:value-of select='atom:title'/>
            </a>
            <ul class="menu">
              <li class="menu-item">
                <a class="button" href='https://www.mozilla.org/'>
                  Visit mozilla.org
                </a>
              </li>
            </ul>
          </nav>
        </div>
    </xsl:template>
</xsl:stylesheet>
