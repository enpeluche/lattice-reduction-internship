import { loadTableOfContents } from "./src/components/TableOfContents/TableOfContents.js";
import { createNews } from "./src/components/News/News.js";
import { createProject } from "./src/components/Project/Project.js";
import { makeArticle } from "./src/components/Course/Course.js";
import { loadFooter } from "./src/components/Footer/footer.js";
import { setupKatex } from "./src/katex-config.js";

document.addEventListener("DOMContentLoaded", () => {
  loadTableOfContents();
  createProject();
  createNews();
  makeArticle();
  setupKatex();
  loadFooter();
});
