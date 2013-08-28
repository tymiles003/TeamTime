{* Smarty *}
<div id="dBriefing">
{if isset($titre.intitule)}
<h2>Gestion des {$titre.intitule}</h2>
{foreach from=$datas key=k item=brief name=data}
{if $smarty.foreach.data.first}
<h3>Liste actuelle des {$titre.intitule}</h3>
<table class="altern-row">
{/if}
<tr>
<td>{$brief.description}</td><td> du {$brief.dateD} au {$brief.dateF}</td><td><a href="delGestion.php?id={$brief.id}&t={$brief.t}"><div class="imgwrapper12"><img class="cnl" alt="supprimer" src="{$image}" /></div></a></td>
</tr>
{/foreach}
</table>
<h3>Ajouter des {$titre.intitule}</h3>
<form name="form{$titre.t}" action="addGestion.php" method="post">
<label for="desc">Description ({$descLength} caractères maxi)</label>
<input type="text" name="desc" id="desc" maxlength={$descLength} />
<label for="dateD">Date de début des {$titre.intitule}</label>
<input type="text" name="dateD" id="dateD" />
<label for="dateF">Date de fin des {$titre.intitule}</label>
<input type="text" name="dateF" id="dateF" />
<input type="hidden" name="t" value="{$titre.t}" />
<input type="submit" value="Envoyer" />
</form>
{else}
<ul>
<li><a href="gestion.php?q=briefing">Gérer les briefings à venir</a></li>
<li><a href="gestion.php?q=charge">Gérer les périodes de charge à venir</a></li>
<li><a href="gestion.php?q=vacances">Gérer les vacances scolaires à venir</a></li>
</ul>
{/if}
</div>
