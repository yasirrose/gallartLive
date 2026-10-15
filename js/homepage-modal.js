/* Public homepage newsletter popup. Bootstrap 5 owns the existing markup and styling. */
(function () {
    "use strict";

    function initializeNewsletterModal() {
        var element = document.getElementById("onload");
        if (!element || !window.bootstrap || !window.bootstrap.Modal) {
            return;
        }

        var modal = window.bootstrap.Modal.getOrCreateInstance(element);
        // Check if the modal has already been shown using localStorage
        var alreadyShown = false;
        try {
            alreadyShown = !!window.localStorage.getItem("modalShown");
        } catch (error) {
            // Browsers can block storage; the popup must still work in this visit.
        }

        if (!alreadyShown) {
            // If modal is not shown yet, show it
            modal.show();
            try {
                window.localStorage.setItem("modalShown", "true"); // Store that modal has been shown
            } catch (error) {
                // Persistence is optional and must not interrupt the rest of the page.
            }
        }

        // Close the modal when clicking anywhere on the page
        document.addEventListener("click", function (event) {
            if (!element.contains(event.target)) {
                // If click is outside the modal, hide it and set the localStorage flag
                modal.hide();
            }
        });
    }

    if (document.readyState === "complete") {
        initializeNewsletterModal();
    } else {
        window.addEventListener("load", initializeNewsletterModal, { once: true });
    }
}());
