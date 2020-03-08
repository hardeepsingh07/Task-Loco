class ApiResponse {
    constructor(responseCode, message, data, error) {
        this.responseCode = responseCode;
        this.message = message;
        this.data = data;
        this.error = error;
    }
}

module.exports = ApiResponse;
