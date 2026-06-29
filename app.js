let SaveBtn = document.querySelector(".btn-save");
let notepad = document.querySelector("#note");
let container = document.querySelector(".container");

SaveBtn.addEventListener("click", () => {
  if (notepad.value.trim() === "") {
    alert("Please write something!");
  } else {
    let taskItem = document.createElement("div");
    taskItem.classList.add("task-item");

    taskItem.innerHTML = `
      <span class="value-icon">${notepad.value}</span>
      <span class="icons">
        <i class="fa-solid fa-trash delete-icon"></i>
        <i class="fa-solid fa-pen update-icon"></i>
      </span>
    `;

    container.appendChild(taskItem);

    // Delete functionality
    taskItem.querySelector(".delete-icon").addEventListener("click", () => {
      taskItem.remove();
    });

    // Update functionality
    taskItem.querySelector(".update-icon").addEventListener("click", () => {
      notepad.value = taskItem.querySelector(".value-icon").textContent;
      taskItem.remove();
    });

    // Clear the notepad input
    notepad.value = "";
  }
});
