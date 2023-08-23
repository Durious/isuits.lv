// Select the target node
const targetNode = document.querySelector('.body-overlay');

// Options for the observer (which mutations to observe)
const config = { attributes: true, attributeFilter: ['class'] };

// Callback function to execute when mutations are observed
const callback = function(mutationsList, observer) {
    for(let mutation of mutationsList) {
        if (mutation.type === 'attributes' && mutation.attributeName === 'class') {
            if (mutation.target.classList.contains('active')) {
                // Perform additional actions here when the 'active' class is added
                document.body.style.overflowY = 'hidden';
            } else {
                // Perform additional actions here when the 'active' class is removed
                document.body.style.overflowY = 'auto';
            }
        }
    }
};

// Create an observer instance linked to the callback function
const observer = new MutationObserver(callback);

// Start observing the target node for configured mutations
observer.observe(targetNode, config);