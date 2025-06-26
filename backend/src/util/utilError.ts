import { UtilMessage } from "./utilMessage";

export class UtilError extends Error {
  public statusCode: number;

  constructor(statusCode: number = 500, message?: string) {
    super(message || UtilMessage.messages[statusCode]);
    this.statusCode = statusCode;
    Object.setPrototypeOf(this, UtilError.prototype);
  }
}
