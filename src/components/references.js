import { APP_ROOT } from "../main.js";
async function fetchReferences() {
  const paths = [`${APP_ROOT}src/data/references.json`];

  for (const path of paths) {
    try {
      const res = await fetch(path);
      if (res.ok) return await res.json();
    } catch (e) {}
  }
  return null;
}

/**
 * @param {object} options - Objet de configuration du lien.
 * @param {string} options.href - L'URL de destination (OBLIGATOIRE).
 * @param {string} [options.hreflang="fr"] - Langue de la ressource.
 * @param {string} [options.target="_self"] - Cible d'ouverture.
 * @param {string} [options.rel="noopener noreferrer"] - Relation du lien.
 * @param {string} [options.title] - Titre d'infobulle.
 * @returns {HTMLAnchorElement}
 */
export function createLink({
  href,
  title,
  hreflang = "fr",
  target = "_self",
  rel = "noopener noreferrer",
  textContent,
}) {
  const a = document.createElement("a");

  a.href = href;
  a.hreflang = hreflang;
  a.target = target;
  a.rel = rel;
  a.title = title;
  a.textContent = textContent;

  return a;
}

function createAuthor(author) {
  return `
		<span class="author">
			${author.given[0]}. ${author.family}
		</span>
	`;
}

export async function loadReferences() {
  const refs = document.querySelectorAll("a[class^=ref-]");
  if (refs.length === 0) return;

  const referencesData = await fetchReferences();
  if (!referencesData) return;

  const refList = [];

  refs.forEach((ref) => {
    const elt = referencesData.find((REF) => REF.id === ref.className);

    if (!refList.includes(elt)) {
      refList.push(elt);
    }

    ref.title = elt.title;
    ref.href = "#" + ref.className;

    ref.innerHTML = `
			<span class="author">
				${createAuthor(elt.authors[0])},
			</span>
			<strong>
			${elt.year}
			</strong>
		`;
  });

  createReferencesList(refList);
}

function createReferencesList(refList) {
  if (refList.length === 0) return;

  const container = document.getElementById("article");

  const referencesList = refList
    .map((ref) => {
      const listAuthors = ref.authors
        .map((author) => {
          return createAuthor(author);
        })
        .join(",");

      return `
				<li id="${ref.id}" class="" style="">
					<div>
						${listAuthors}
						<strong>
							${ref.year};
						</strong>
					</div>
					<a
					href="${ref.url}"
					hreflang="fr"
					target="_self"
					rel="noopener noreferrer"
					title="Accèder a l'article"
					>
						${ref.title}
					</a>
				</li>
				`;
    })
    .join("");

  container.insertAdjacentHTML(
    "beforeend",
    `
	<hr>
	
	<h1>Références</h1>
	
	<ol  class="references" style="">
		${referencesList}
	</ol>
	`,
  );
}
