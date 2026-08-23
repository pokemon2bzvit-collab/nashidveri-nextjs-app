import { ButtonHTMLAttributes, forwardRef } from "react";
export const Button = forwardRef<HTMLButtonElement, ButtonHTMLAttributes<HTMLButtonElement> & { variant?: "default" | "outline" }>(({ className = "", variant = "default", ...props }, ref) => <button ref={ref} className={`${variant === "default" ? "button-primary" : "button-light"} ${className}`} {...props} />);
Button.displayName = "Button";
