import { createNews } from "./components/News/News.js";
import { createProject } from "./components/Project/Project.js";

import { loadTableOfContents } from "./components/toc.js";
import { makeArticle } from "./components/course.js";
import { loadFooter } from "./components/footer.js";
import { loadReferences } from "./components/references.js";
import { makeAlgorithm } from "./components/algorithm.js";

document.addEventListener("DOMContentLoaded", () => {
  loadTableOfContents();
  createProject();
  createNews();
  makeArticle();
  makeAlgorithm();
  loadFooter();
  loadReferences();
});

// On détecte si on est en local ou sur GitHub Pages
const isProduction = window.location.hostname.includes("github.io");

// Si Prod : on ajoute le nom du repo. Si Local : on reste à la racine.
export const APP_ROOT = isProduction ? "/lattice-reduction-internship/" : "/";
