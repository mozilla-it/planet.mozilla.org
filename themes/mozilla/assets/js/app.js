function filterSubscriptionList() {
  const pattern = /^\s+|\s+$/g;
  const list = Array.from(document.querySelectorAll("#subscription-list li"));
  const search = document
                  .querySelector("#filter-subscription-list")
                  .value.replace(pattern, "")
                  .toLowerCase();

  for (const i in list) {
    const text = list[i].querySelector("span");

    if (text.innerText.replace(pattern, "").toLowerCase().includes(search) ||
        !search) {
      list[i].style.display = "flex";
    } else {
      list[i].style.display = "none";
    }
  }
}

const filterSubscriptionInput = document.querySelector("#filter-subscription-list");
filterSubscriptionInput.addEventListener("input", filterSubscriptionList);
