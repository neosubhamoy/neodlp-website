import React from "react";
import { Copy, Terminal } from "lucide-react";
import { toast } from "sonner";

export const CommandSnippet = ({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) => {
    const handleCopy = () => {
        const command = children?.toString();
        if (command) {
            navigator.clipboard.writeText(command).then(() => {
                toast("Copied to clipboard!");
            }).catch((err) => {
                toast("Failed to copy to clipboard!");
                console.error("Failed to copy command:", err);
            });
        }
    }

    return (
        <div className="flex flex-col rounded-lg border border-border overflow-hidden w-[20rem] md:w-[30rem]">
            <div className="flex items-center justify-between px-4 py-1 gap-2 bg-muted">
                <div className="flex items-center gap-2">
                    <Terminal className="size-4" />
                    <span className="text-xs text-muted-foreground">{title}</span>
                </div>
                <button className="flex items-center gap-2 cursor-pointer text-muted-foreground hover:text-primary" onClick={handleCopy}>
                    <Copy className="size-4" />
                    <span className="text-xs">Copy</span>
                </button>
            </div>
            <code className="flex px-4 py-2 overflow-x-scroll text-nowrap">
                <p className="">{children}</p>
            </code>
        </div>
    );
}