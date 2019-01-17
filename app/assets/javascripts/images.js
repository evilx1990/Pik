let current_index;  // Индекс текущего изображения
let modal;          // Модальное окно
let images;         // Массив картинок в модальном окне

function showModal(index) {
  modal = document.querySelector('#index-slider');
  images = document.querySelectorAll('.slider-image');

  modal.style.display = 'block';
  modal.parentNode.style.overflow = 'hidden';

  images[index].classList.add('show-image');
  current_index = index;
}

function next() {
  images[current_index++].classList.remove('show-image');

  if (current_index === images.length) {
    current_index = 0;
  }

  images[current_index].classList.add('show-image');
}

function prev() {
  images[current_index--].classList.remove('show-image');

  if (current_index < 0) {
    current_index = images.length - 1;
  }

  images[current_index].classList.add('show-image');
}

function hideModal() {
  modal.style.display = 'none';
  modal.parentNode.style.overflow = 'visible';
  images[current_index].classList.remove('show-image');
}
