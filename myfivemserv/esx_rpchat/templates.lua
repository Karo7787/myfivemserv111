Citizen.CreateThread(function ()
	Citizen.Wait(2000)

	CreateTemplates()
end)

RegisterCommand("fixchat", function(source)
    CreateTemplates()
	Citizen.Wait(1000)
	TriggerEvent("chat:addMessage", {
		templateId = "message",
		multiline = true,
		args = {"100, 0, 0", "fa-solid fa-comment-alt-dots", "INFORMACJA", "Jeśli widzisz tą wiadomość to chat został poprawnie załadowany! 😎", "SYSTEM"}
	})
end)


function CreateTemplates() 
	  TriggerEvent("chat:addTemplate", "message", [[
		<div class="message-box" style="--color: rgb({0})">
			<div class="message-icon">
				<i class="icon-svg {1}"></i>
				<svg class="icon-hexagon" xmlns="http://www.w3.org/2000/svg" viewBox="45 45 930 930">
					<path fill="#040e1b" stroke="rgb({0})" stroke-width="24" d="M896 704C896 720.213333 887.04 734.293333 873.386667 741.546667L536.32 930.986667C529.493333 936.106667 520.96 938.666667 512 938.666667 503.04 938.666667 494.506667 936.106667 487.68 930.986667L150.613333 741.546667C136.96 734.293333 128 720.213333 128 704L128 320C128 303.786667 136.96 289.706667 150.613333 282.453333L487.68 93.013333C494.506667 87.893333 503.04 85.333333 512 85.333333 520.96 85.333333 529.493333 87.893333 536.32 93.013333L873.386667 282.453333C887.04 289.706667 896 303.786667 896 320L896 704Z"/>
				</svg>
				<div class="icon-background" style="--color: rgba({0}, 0.82)"></div>
			</div>
			<div class="message-content">
				<div class="message-title">
					<span>{2}</span>
					<span class="time">{4}</span>
				</div>
				<div class="message-text">{3}</div>
			</div>
		</div>
	  ]])
end