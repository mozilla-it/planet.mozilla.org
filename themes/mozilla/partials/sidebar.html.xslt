<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:planet="http://planet.intertwingly.net/"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="atom planet xhtml">
      <xsl:template name="sidebar">
          <div class="sidebar-content">
            <div class="sidebar-section">
              <h2 class="h3">About</h2>
              <p>
                Collected here are the most recent blog posts from all over the
                Mozilla community. The content here is unfiltered and uncensored,
                and represents the views of individual community members.
                Individual posts are owned by their authors. See original source
                for licensing information.
              </p>
            </div>
            <div class="sidebar-section">
              <h2 class="h3">Subscribe</h2>
              <ul class="menu vertical">
                <li class="menu-item">
                  <img src="assets/img/feed.svg" width="16" height="16" alt="" />
                  <a href='atom.xml'>Atom</a>
                </li>
                <li class="menu-item">
                  <img src="assets/img/feed.svg" width="16" height="16" alt="" />
                  <a href='rss20.xml'>RSS 2.0</a>
                </li>
                <li class="menu-item">
                  <img src="assets/img/feed.svg" width="16" height="16" alt="" />
                  <a href='rss10.xml'>RSS 1.0</a>
                </li>
                <li class="menu-item">
                  <img src="assets/img/foaf.svg" width="16" height="12" alt="" />
                  <a href='foafroll.xml'>FOAF</a>
                </li>
                <li class="menu-item">
                  <img src="assets/img/opml.svg" width="16" height="16" alt="" />
                  <a href='opml.xml'>OPML</a>
                </li>
                <li class="menu-item">
                  <a href='subscriptions.html'>View subscription list</a>
                </li>
              </ul>
            </div>

            <div class="sidebar-section">
              <h2 class="h3">Other Planets</h2>
              <ul class='planets menu vertical'>
                <li class="menu-item"><a href='https://planet.mozilla.org/projects/'>Projects</a></li>
                <li class="menu-item"><a href="https://planet.mozilla.org/participation/">Planet Participation</a></li>
                <li class="menu-item"><a href='https://planet.mozilla.org/thunderbird/'>Planet Thunderbird</a></li>
                <li class="menu-item"><a href='https://quality.mozilla.org/'>Planet QMO</a></li>
                <li class="menu-item"><a href='https://planet.mozilla.org/ateam/'>Planet Automation</a></li>
                <li class="menu-item"><a href='https://planet.mozilla.org/research/'>Mozilla Research</a></li>
              </ul>
            </div>
            <div id='footer'>
              <div id='footer-content'>
                <p>
                  Maintained by the <a href='https://bugzilla.mozilla.org/enter_bug.cgi?product=Websites&amp;component=planet.mozilla.org'>Planet Mozilla Module Team</a>. Powered by <a href='http://www.intertwingly.net/code/venus/'>Planet Venus</a>. View our <a href='https://www.mozilla.org/about/policies/privacy-policy.html'>Privacy Policy</a>.
                </p>
              <p>
                Last update:
                <time datetime="{atom:updated}" title="GMT">
                  <xsl:value-of select='atom:updated/@planet:format'/>
                </time>
              </p>
              </div>
            </div>
          </div>
    </xsl:template>
</xsl:stylesheet>
