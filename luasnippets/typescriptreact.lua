return {
  s("div", { t("<div>"), i(1), t("</div>") }),


  s("span", { t("<span>"), i(1), t("</span>") }),
  s("p", { t("<p>"), i(1), t("</p>") }),
  s("h1", { t("<h1>"), i(1), t("</h1>") }),
  s("h2", { t("<h2>"), i(1), t("</h2>") }),
  s("h3", { t("<h3>"), i(1), t("</h3>") }),
  s("ul", { t("<ul>"), i(1), t("</ul>") }),
  s("li", { t("<li>"), i(1), t("</li>") }),
  s("a", { t('<a href="'), i(1, "#"), t('">'), i(2, "link"), t('</a>') }),
  s("img", { t('<img src="'), i(1), t('" alt="'), i(2), t('" />') }),
  s("input", { t('<input type="'), i(1, "text"), t('" name="'), i(2), t('" />') }),
  s("button", { t('<button>'), i(1, "Click me"), t('</button>') }),
  s("form", { t('<form action="'), i(1), t('" method="'), i(2, "post"), t('">'), i(3), t('</form>') }),
  s("label", { t('<label for="'), i(1), t('">'), i(2), t('</label>') }),
  s("section", { t('<section>'), i(1), t('</section>') }),
  s("article", { t('<article>'), i(1), t('</article>') }),
  s("header", { t('<header>'), i(1), t('</header>') }),
  s("footer", { t('<footer>'), i(1), t('</footer>') }),
  s("nav", { t('<nav>'), i(1), t('</nav>') }),
  s("main", { t('<main>'), i(1), t('</main>') }),
  s("li", { t("<li>"), i(1), t("</li>") }),
  s("aside", { t('<aside>'), i(1), t('</aside>') }),



  s("divc", { t('<div className="'), i(1), t('"></div>') }),
  s("spanc", { t('<span className="'), i(1), t('"></span>') }),
  s("pc", { t('<p className="'), i(1), t('"></p>') }),
  s("h1c", { t('<h1 className="'), i(1), t('"></h1>') }),
  s("h2c", { t('<h2 className="'), i(1), t('"></h2>') }),
  s("h3c", { t('<h3 className="'), i(1), t('"></h3>') }),
  s("ulc", { t('<ul className="'), i(1), t('"></ul>') }),
  s("lic", { t('<li className="'), i(1), t('"></li>') }),


  s("nximg", {
    t('<Image src="'), i(1, "/path.jpg"), t('" alt="'), i(2, "img"), t('" width={'), i(3, "500"), t('} height={'), i(4,
    "300"), t('} />')
  }),
  s("nxlink", {
    t('<Link href="'), i(1, "/route"), t('"><a>'), i(2, "text"), t('</a></Link>')
  }),
  s("nxhead", {
    t('<Head>'), i(1), t('</Head>')
  }),
  s("nxscript", {
    t('<Script src="'), i(1, "/script.js"), t('" strategy="'), i(2, "lazyOnload"), t('" />')
  }),
  s("nxmeta", {
    t('<meta name="'), i(1, "viewport"), t('" content="'), i(2, "width=device-width, initial-scale=1.0"), t('" />')
  }),
  s("nxstyle", {
    t('<style jsx>{`'), i(1, "\n\n"), t('`}</style>')
  }),
}
