export function makeArticle() {
  const hoho = document.querySelectorAll(
    ".example, .counterexample, .proof, .conjecture, .definition, .remark, .theorem, .proposition, .lemma, .problem, .notation, figcaption, summary",
  );
  hoho.forEach((example) => {
    example.insertAdjacentHTML(
      "afterbegin",
      `
            <span class="label"></span>
        `,
    );
  });

  const proofs = document.querySelectorAll(".proof");

  proofs.forEach((proof) => {
    const endProofContainer = document.createElement("div");
    endProofContainer.className = "end-proof";

    const qedSvg = `
            <svg class="qed" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#000000" viewBox="0 0 256 256">
                <path d="M224,48V208a16,16,0,0,1-16,16H48a16,16,0,0,1-16-16V48A16,16,0,0,1,48,32H208A16,16,0,0,1,224,48Z"></path>
            </svg>
        `;

    endProofContainer.innerHTML = qedSvg;

    proof.appendChild(endProofContainer);
  });
}
