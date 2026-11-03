import { useEffect, useRef, type ReactNode } from 'react';

interface AdminDialogProps {
  title: string;
  busy?: boolean;
  wide?: boolean;
  onClose: () => void;
  children: ReactNode;
}

export default function AdminDialog({ title, busy = false, wide = false, onClose, children }: AdminDialogProps) {
  const dialog = useRef<HTMLDialogElement>(null);

  useEffect(() => {
    const element = dialog.current;
    const origin = document.activeElement instanceof HTMLElement ? document.activeElement : null;
    const previousOverflow = document.body.style.overflow;
    element?.showModal();
    document.body.style.overflow = 'hidden';
    return () => {
      element?.close();
      document.body.style.overflow = previousOverflow;
      if (origin?.isConnected) origin.focus();
    };
  }, []);

  return (
    <dialog ref={dialog} aria-label={title} aria-busy={busy}
      onCancel={event => { event.preventDefault(); if (!busy) onClose(); }}
      className={`m-auto max-h-[calc(100dvh-2rem)] w-[calc(100%-2rem)] overflow-y-auto rounded-2xl border border-[#cbd5e1] bg-[#ffffff] p-0 text-[#16324f] shadow-2xl backdrop:bg-[#16324f]/60 ${wide ? 'max-w-2xl' : 'max-w-md'}`}>
      {children}
    </dialog>
  );
}
