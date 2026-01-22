// OldStock-2017 Cordova Mocking Layer
// This script simulates the presence of Cordova plugins in a browser environment

window.cordova = {
    platformId: 'browser',
    plugins: {
        barcodeScanner: {
            scan: function (success, fail) {
                console.log("Mocking Barcode Scan...");
                setTimeout(function () {
                    // Typical barcode scanner result object from 2017
                    success({
                        text: "880123456789",
                        format: "EAN_13",
                        cancelled: false
                    });
                }, 1000);
            }
        }
    }
};

window.navigator.camera = {
    getPicture: function (success, fail, options) {
        console.log("Mocking Camera Capture...");
        // Simulating the base64 return value
        setTimeout(function () {
            // Using a real visual placeholder to make it "work"
            var mockBase64 = "iVBORw0KGgoAAAANSUhEUgAAAFAAAABQCAYAAACOEfKtAAAACXBIWXMAAAsTAAALEwEAmpwYAAABNmlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjarZExS8NQFIW/tSAtSiuIdMhQREidXByEgIitYitYpToIdcl7vU8SkhS/vE7i4uTioODm5OLk4uDk4ODm5uXm5ubm5eXm5ubm5ubm5ubm5ubm5ubm5ubm5uXm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5v/8L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L73L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L7/L73P//AAAABJRU5ErkJggg==";
            success(mockBase64);
        }, 1500);
    },
    DestinationType: {
        DATA_URL: 0,
        FILE_URI: 1
    }
};

window.Camera = window.navigator.camera;
