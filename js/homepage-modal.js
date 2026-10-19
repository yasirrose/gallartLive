/* Public homepage newsletter popup. Bootstrap 5 owns the existing markup and styling. */
(function () {
    "use strict";

    function initializeNewsletterModal() {
        var element = document.getElementById("onload");
        if (!element || !window.bootstrap || !window.bootstrap.Modal) {
            return;
        }

        var modal = window.bootstrap.Modal.getOrCreateInstance(element);
        var previousFocus = null;
        element.addEventListener("show.bs.modal", function () {
            previousFocus = document.activeElement;
        });
        element.addEventListener("hide.bs.modal", function (event) {
            if (!event.defaultPrevented && element.contains(document.activeElement)) {
                // Release focus before Bootstrap hides the modal from assistive technology.
                document.activeElement.blur();
            }
        });
        element.addEventListener("hidden.bs.modal", function () {
            // Restore keyboard position after Bootstrap has deactivated its focus trap.
            if (previousFocus && previousFocus.isConnected &&
                    !element.contains(previousFocus)) {
                previousFocus.focus({ preventScroll: true });
            }
        });
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
