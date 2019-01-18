let current_index;  // Индекс текущего изображения
let modal;          // Модальное окно
let images;         // Массив картинок в модальном окне

window.onkeydown = function (event) {
  if(!['ArrowRight', 'ArrowLeft'].includes(event.key)){
    return null;
  }

  if(modal.style.display === 'block') {
    event.key === 'ArrowRight'? next() : prev();
  }
};

function showModal(index) {
  modal = document.querySelector('#index-slider');
  images = document.querySelectorAll('.hidden-image');

  modal.style.display = 'block';
  modal.parentNode.style.overflow = 'hidden';

  images[index].classList.remove('hidden-image');
  images[index].classList.add('show-image');
  current_index = index;
}

function next() {
  images[current_index].classList.add('hidden-image');
  images[current_index++].classList.remove('show-image');

  if (current_index === images.length) {
    current_index = 0;
  }

  images[current_index].classList.remove('hidden-image');
  images[current_index].classList.add('show-image');
}

function prev() {
  images[current_index].classList.add('hidden-image');
  images[current_index--].classList.remove('show-image');

  if (current_index < 0) {
    current_index = images.length - 1;
  }

  images[current_index].classList.remove('hidden-image');
  images[current_index].classList.add('show-image');
}

function hideModal() {
  modal.style.display = 'none';
  modal.parentNode.style.overflow = 'visible';
  images[current_index].classList.remove('show-image');
}
